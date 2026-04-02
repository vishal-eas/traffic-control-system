cmake_minimum_required(VERSION 3.10)
project(TrafficControlSystem CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Common library for shared code
add_library(common
    src/common/Grid.cpp
    src/common/Intersection.cpp
    src/common/Road.cpp
    src/common/TrafficLight.cpp
    src/common/Vehicle.cpp
)
target_include_directories(common PUBLIC include)

# Infrastructure executable
add_executable(infrastructure_sim 
    src/infrastructure/main.cpp
    src/infrastructure/InfrastructureAgent.cpp
)
target_include_directories(infrastructure_sim PUBLIC include)
target_link_libraries(infrastructure_sim common)

# Vehicle executable
add_executable(vehicle_sim 
    src/vehicle/main.cpp
    src/vehicle/VehicleAgent.cpp
    src/infrastructure/InfrastructureAgent.cpp
)
target_include_directories(vehicle_sim PUBLIC include)
target_link_libraries(vehicle_sim common)
