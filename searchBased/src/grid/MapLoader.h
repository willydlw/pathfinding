#pragma once

#include <iostream>
#include <string>
#include <vector>


class MapLoader
{
    public:

    static constexpr int DEFAULT_ROWS = 32;
    static constexpr int DEFAULT_COLS = 32;
    static constexpr int DEFAULT_MAP_SYMBOL = 0;

    public:

    MapLoader();
    MapLoader(int rows, int cols);

    void loadMap(const std::string& filename);

    ~MapLoader();

    friend std::ostream& operator << (std::ostream& os, const MapLoader& map);

    private:

    int rows;
    int cols;
    std::vector<int> map;       // using single vector for contiguous memory and better cache performance
                                // data[row * num_cols + col]

    void loadDefaultMap();
};