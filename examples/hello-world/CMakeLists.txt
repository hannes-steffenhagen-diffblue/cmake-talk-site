cmake_minimum_required(VERSION 3.5)

project(hello-world)

add_library(hello-world-lib STATIC
  src/hello_world.cpp)

target_include_directories(hello-world-lib
  PUBLIC
  include)

add_executable(hello-world-exe
  app_src/main.cpp)

target_link_libraries(hello-world-exe
  PRIVATE
  hello-world-lib)
