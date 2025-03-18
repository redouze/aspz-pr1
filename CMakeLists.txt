# minimum
cmake_minimum_required(VERSION 3.10)
# name
project (MyProgram)
# source
add_executable(my_program main.c input.c output.c)
# specify libs
target_link_libraries (my_program PRIVATE process)
# enable debug and optimization
set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O2")