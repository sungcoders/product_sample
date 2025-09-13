cmake_minimum_required(VERSION 3.10)

# Tên project tổng
project(ProductProject CXX)

# Đặt chuẩn C++
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Thêm các thư mục con
add_subdirectory(mycpp)
add_subdirectory(mysrc1)
