# Top-level CMakeLists.txt 
cmake_minimum_required(VERSION 3.28)

# super project name: pathfinding 
project(pathfinding LANGUAGES CXX)

# add sub-project directories 
add_subdirectory(dependencies)
add_subdirectory(searchBased)

