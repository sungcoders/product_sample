cmake_minimum_required(VERSION 3.10)

# project name
project(ProductProject CXX)

# C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# add subdirectories
add_subdirectory(mycpp)
add_subdirectory(mysrc1)
