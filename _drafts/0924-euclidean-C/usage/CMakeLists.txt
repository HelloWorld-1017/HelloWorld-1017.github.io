cmake_minimum_required(VERSION 3.23)
project(usage C)

set(CMAKE_C_STANDARD 11)

include_directories(.)

add_executable(usage
        euclidean.c
        euclidean.h
        main.c
        main.h
        norm.c
        norm.h
        rtwtypes.h)
