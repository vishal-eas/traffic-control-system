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

# Throughput benchmark executable
add_executable(throughput_bench
    src/throughput/main.cpp
    src/vehicle/VehicleAgent.cpp
    src/infrastructure/InfrastructureAgent.cpp
)
target_include_directories(throughput_bench PUBLIC include)
target_link_libraries(throughput_bench common)

# Tests
enable_testing()

add_executable(test_infrastructure
    tests/test_infrastructure.cpp
    src/infrastructure/InfrastructureAgent.cpp
)
target_include_directories(test_infrastructure PUBLIC include)
target_link_libraries(test_infrastructure common)
add_test(NAME infrastructure_agent_test COMMAND test_infrastructure)

add_executable(test_vehicle_agent
    tests/test_vehicle_agent.cpp
    src/vehicle/VehicleAgent.cpp
    src/infrastructure/InfrastructureAgent.cpp
)
target_include_directories(test_vehicle_agent PUBLIC include)
target_link_libraries(test_vehicle_agent common)
add_test(NAME vehicle_agent_test COMMAND test_vehicle_agent)
