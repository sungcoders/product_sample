cmake_minimum_required(VERSION 3.10)

# Tên project
project(MyCppProject LANGUAGES CXX)

# C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Thêm đường dẫn include (để tìm hello.h trong inc/)
include_directories(${PROJECT_SOURCE_DIR}/inc)

# Gom tất cả executable vào build/bin
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# Tạo executable
add_executable(my_app
    main.cpp
    src/hello.cpp
)

# Gom tất cả library (shared/static) vào build/lib
# set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Nếu sau này muốn build thư viện thay vì exe thì dùng:
# add_library(my_lib src/hello.cpp)
# target_link_libraries(my_app my_lib)
