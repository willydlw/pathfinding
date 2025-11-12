# SubProject searchBased/CMakeLists.txt
project(searchBased)

# specify binary output directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

# set compiler flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -std=c++17 -Wall -Wextra -Werror -pedantic")
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)   # optional: Set to OFF for more portable code


include_directories("include")

# create executables
add_executable(findPath)
target_sources(findPath PUBLIC 
    src/main.cpp
)


# Link to other libraries
# PUBLIC m links math library
target_link_libraries(findPath
    PRIVATE SFML::Graphics
    PRIVATE ImGui-SFML::ImGui-SFML
    PUBLIC  m
)
