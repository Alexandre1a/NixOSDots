# Make sure to change some parameter to fit your project 

cmake_minimum_required(VERSION 3.22)
project(MyApp LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(myapp
    src/main.cpp
    src/utils.cpp
)

# This is the install rule - it tells CMake where to put the binary
# when 'make install' or 'ninja install' is run
install(TARGETS myapp
    RUNTIME DESTINATION bin
)

# If you have data files, you can install them too:
# install(FILES assets/config.json
#     DESTINATION share/myapp
# )
