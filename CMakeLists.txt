# Top-level CMakeLists.txt 
cmake_minimum_required(VERSION 3.28)

# super project name: pathfinding 
project(pathfinding LANGUAGES CXX)

# add sub-project directories 
add_subdirectory(dependencies)
add_subdirectory(searchBased)


# copy resource files to binary directories
set(SOURCE_ASSET_DIR "${CMAKE_CURRENT_SOURCE_DIR}/assets")
set(DESTINATION_ASSET_DIR "${CMAKE_CURRENT_BINARY_DIR}/assets")

file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/assets")
file(COPY ${SOURCE_ASSET_DIR}/ DESTINATION "${DESTINATION_ASSET_DIR}")