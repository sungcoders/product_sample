cmake_minimum_required(VERSION 3.10)

# project name
project(MyCppProject LANGUAGES CXX)

# C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# include directories
include_directories(${PROJECT_SOURCE_DIR}/inc)

# set output directory for executables
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# create executable
add_executable(my_app
    main.cpp
    src/hello.cpp
)

# set output directory for libraries (shared/static vào build/lib)
# set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# build library ibnstead of executable
# add_library(my_lib src/hello.cpp)
# target_link_libraries(my_app my_lib)
