#include <array>
#include <cassert>
#include <iostream>
#include <vector>

#include "common/Grid.h"
#include "infrastructure/InfrastructureAgent.h"
#include "vehicle/VehicleAgent.h"

using common::Grid;
using common::Point;
using infrastructure::InfrastructureAgent;
using vehicle::VehicleAgent;

namespace {
int squareIndex(const Point& position) {
    if (position == common::SQUARE_A) return 0;
    if (position == common::SQUARE_B) return 1;
    if (position == common::SQUARE_C) return 2;
    if (position == common::SQUARE_D) return 3;
    return -1;
}
}

int main() {
    std::cout << "Running vehicle agent tests...\n";

    // Test 1: A single vehicle with a simple goal should progress and complete.
    {
        Grid grid;
        VehicleAgent vehicle_agent(grid);
        InfrastructureAgent infra_agent(grid);

        vehicle_agent.addVehicle(1, common::SQUARE_A);
        common::Vehicle* vehicle = vehicle_agent.getVehicleById(1);
        assert(vehicle && "Vehicle should exist after creation.");
        vehicle->setRoute({common::SQUARE_B});

        bool moved_onto_road = false;
        bool reached_goal = false;

        for (int step = 0; step < 800; ++step) {
            infra_agent.step();
            vehicle_agent.step();

            vehicle = vehicle_agent.getVehicleById(1);
            assert(vehicle && "Vehicle should remain present in the grid.");

            auto detailed_pos = vehicle->getDetailedPosition();
            if (!detailed_pos.at_intersection) {
                moved_onto_road = true;
            }

            if (vehicle->getPosition() == common::SQUARE_B && vehicle->getRoute().empty()) {
                reached_goal = true;
                break;
            }
        }

        assert(moved_onto_road && "Vehicle should move from square/intersection onto a road slot.");
        assert(reached_goal && "Vehicle should eventually reach the requested square goal.");
    }

    // Test 2: Three vehicles should complete multi-goal tours and return to A.
    {
        Grid grid;
        VehicleAgent vehicle_agent(grid);
        InfrastructureAgent infra_agent(grid);

        vehicle_agent.addVehicle(1, common::SQUARE_A);
        vehicle_agent.addVehicle(2, common::SQUARE_A);
        vehicle_agent.addVehicle(3, common::SQUARE_A);

        common::Vehicle* v1 = vehicle_agent.getVehicleById(1);
        common::Vehicle* v2 = vehicle_agent.getVehicleById(2);
        common::Vehicle* v3 = vehicle_agent.getVehicleById(3);
        assert(v1 && v2 && v3 && "All vehicles should be created.");

        v1->setRoute({common::SQUARE_B, common::SQUARE_C, common::SQUARE_D, common::SQUARE_A});
        v2->setRoute({common::SQUARE_C, common::SQUARE_B, common::SQUARE_D, common::SQUARE_A});
        v3->setRoute({common::SQUARE_D, common::SQUARE_B, common::SQUARE_C, common::SQUARE_A});

        std::array<std::array<bool, 4>, 3> visited{};
        for (auto& row : visited) {
            row.fill(false);
        }

        for (int step = 0; step < 1500; ++step) {
            infra_agent.step();
            vehicle_agent.step();

            for (int vehicle_id = 1; vehicle_id <= 3; ++vehicle_id) {
                common::Vehicle* vehicle = vehicle_agent.getVehicleById(vehicle_id);
                assert(vehicle && "Vehicle should remain present in the grid.");

                int sq = squareIndex(vehicle->getPosition());
                if (sq >= 0) {
                    visited[vehicle_id - 1][sq] = true;
                }
            }
        }

        for (int vehicle_id = 1; vehicle_id <= 3; ++vehicle_id) {
            common::Vehicle* vehicle = vehicle_agent.getVehicleById(vehicle_id);
            assert(vehicle && "Vehicle should remain present in the grid.");

            assert(vehicle->getPosition() == common::SQUARE_A &&
                   "Vehicle should end at square A after completing its tour.");
            assert(vehicle->getRoute().empty() &&
                   "Vehicle should have no remaining waypoints at end of simulation.");

            for (int sq = 0; sq < 4; ++sq) {
                assert(visited[vehicle_id - 1][sq] &&
                       "Each vehicle should visit all four square nodes during the tour.");
            }
        }
    }

    std::cout << "All vehicle tests passed.\n";
    return 0;
}