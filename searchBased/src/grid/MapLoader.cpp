#include "MapLoader.h"

#include "../utility/fileUtility.h"
#include "../utility/ErrorLog.hpp"
#include <fstream>
#include <sstream>

MapLoader::MapLoader() : rows(DEFAULT_ROWS), cols(DEFAULT_COLS), map(rows*cols) 
{
    // intentionally blank
}

MapLoader::MapLoader(int rows, int cols) :
    rows(rows), cols(cols), map(rows*cols)
{
    LOG_DEBUG("constructed with rows: ", rows, ", cols: ", cols, ", map size: ", map.size());
}

MapLoader::~MapLoader()
{
    LOG_DEBUG("Destructor\n");
}

void MapLoader::loadMap(const std::string& filename)
{
    std::ifstream infile(filename, std::ios::in);
    if(!infile.is_open())
    {
        std::filesystem::path currentPath = getWorkingDirectory();
        LOG_ERROR("[File Open Failure - filename: ", filename, "]\nCurrent working directory: ", 
                    currentPath, " loading default map\n");
        loadDefaultMap();
        return;
    }

    LOG_INFO(" successfully opened file: ", filename);

    // first line of file contains rows, cols
    std::string line;
    if(std::getline(infile, line))
    {
        std::istringstream iss(line);
        if(!(iss >> rows) || !(iss >> cols))
        {
            LOG_ERROR("failed to read rows, cols from line: ", line);
        }
    }

    // may be overwriting old map
    map.resize(rows, cols);

    int r = 0;
    while(std::getline(infile, line) && r < rows)
    {
        std::istringstream iss(line);
        for(int c = 0; c < cols; c++)
        {
            if(!( iss >> map[r * cols + c]))
            {
                LOG_ERROR("read failure, file: ", filename, ", row: ", r, "col: ", c, 
                            ", input line: ", line, "\nloading default map");
                loadDefaultMap();
                return;
            }
        }
        r++;
    }

    if(r != rows){
        LOG_WARNING("Not all rows of input may have been read, r: ", r, ", expected r: ", rows,
                    "\nloading default map");
        loadDefaultMap();
        return;
    }

    infile.close();
    LOG_INFO("successfully loaded map");
    std::cerr << "Map Contents\n" << *this << "\n";
}

void MapLoader::loadDefaultMap()
{
    rows = DEFAULT_ROWS;
    cols = DEFAULT_COLS;
    map.resize(rows * cols);
    for(int r = 0; r < rows; r++)
    {
        for(int c = 0; c < cols; c++)
        {
            map[r * cols + c] = DEFAULT_MAP_SYMBOL;
        }
    }
}


 std::ostream& operator << (std::ostream& os, const MapLoader& obj)
 {
    os << "rows: " << obj.rows << ", cols: " << obj.cols << "\n";
    for(int r = 0; r < obj.rows; r++)
    {
        for(int c = 0; c < obj.cols; c++)
        {
            os << obj.map[r * obj.cols + c] << " ";
        }

        os << "\n";
    }

    return os;
 }