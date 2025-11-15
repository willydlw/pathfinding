#pragma once

#include <iostream>
#include <string>
#include <vector>


class MapLoader
{
    public:

    MapLoader();

    friend std::ostream& operator << (std::ostream& os, const MapLoader& map);

    private:

    std::string filename;

    int rows;
    int cols;
    std::vector<int> map;
}