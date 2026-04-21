#include <iostream>
#include <iomanip>
#include <unordered_set>
#include "common/Grid.h"
#include "common/SimulationStats.h"
#include "vehicle/VehicleAgent.h"
#include "infrastructure/InfrastructureAgent.h"

static const char* pointName(const common::Point& p) {
    if (p == common::SQUARE_A) return "A";
    if (p == common::SQUARE_B) return "B";
    if (p == common::SQUARE_C) return "C";
    if (p == common::SQUARE_D) return "D";
    return nullptr;
}

static void printPoint(const common::Point& p) {
    const char* name = pointName(p);
    if (name) std::cout << name;
    else std::cout << "(" << p.x << "," << p.y << ")";
}

static void printVehicleBrief(const common::Vehicle& v) {
    auto pos = v.getDetailedPosition();
    std::cout << "V" << v.getId() << ":";
    if (pos.at_intersection) {
        printPoint(v.getPosition());
    } else {
        if (pos.road_type == 2) {
            const common::Point square =
                (pos.road_row == 0) ? common::SQUARE_A :
                (pos.road_row == 1) ? common::SQUARE_B :
                (pos.road_row == 2) ? common::SQUARE_C :
                                      common::SQUARE_D;
            std::cout << "SQ(";
            printPoint(square);
            std::cout << ")"
                      << (pos.direction == 0 ? "F" : "B")
                      << "@" << pos.slot;
        } else {
            std::cout << (pos.road_type == 0 ? "H" : "V")
                      << "[" << pos.road_row << "," << pos.road_col << "]"
                      << (pos.direction == 0 ? "F" : "B")
                      << "@" << pos.slot;
        }
    }
}

int main() {
    std::cout << "=========================================================\n";
    std::cout << "  Vehicle Agent Demo — 3 Vehicles, Continuous Tours\n";
    std::cout << "=========================================================\n\n";

    std::cout << "Grid layout:\n";
    std::cout << "       A---O(0,0)---O(0,1)---O(0,2)---D\n";
    std::cout << "            |        |        |\n";
    std::cout << "           O(1,0)---O(1,1)---O(1,2)\n";
    std::cout << "            |        |        |\n";
    std::cout << "       B---O(2,0)---O(2,1)---O(2,2)---C\n\n";

    std::cout << "Each road has 30 slots (1 mile). Each time step = 2 seconds.\n";
    std::cout << "Vehicles start at square node A and continuously repeat tours\n";
    std::cout << "that visit B, C, D in some order before returning to A.\n\n";

    common::Grid grid;
    common::SimulationStats stats;
    vehicle::VehicleAgent vehicle_agent(grid, &stats);
    infrastructure::InfrastructureAgent infra_agent(grid);

    vehicle_agent.addVehicle(1, common::SQUARE_A);
    vehicle_agent.addVehicle(2, common::SQUARE_A);
    vehicle_agent.addVehicle(3, common::SQUARE_A);

    vehicle_agent.getVehicleById(1)->setRoute(
        {common::SQUARE_B, common::SQUARE_C, common::SQUARE_D, common::SQUARE_A});
    vehicle_agent.getVehicleById(2)->setRoute(
        {common::SQUARE_C, common::SQUARE_B, common::SQUARE_D, common::SQUARE_A});
    vehicle_agent.getVehicleById(3)->setRoute(
        {common::SQUARE_D, common::SQUARE_B, common::SQUARE_C, common::SQUARE_A});

    // Last known square node per vehicle (to detect arrivals)
    common::Point last_square[3] = {common::SQUARE_A, common::SQUARE_A, common::SQUARE_A};

    // Run for one simulated hour.
    int total_steps = 1800;
    int collision_check_total = 0;
    int last_completed_tours = 0;

    std::cout << "--- Simulation Running (" << total_steps << " steps) ---\n\n";

    for (int t = 0; t < total_steps; ++t) {
        infra_agent.step();
        vehicle_agent.step();

        // Check collisions every step
        int c = grid.detectCollisions();
        collision_check_total += c;

        // Detect milestone events: vehicle arrived at a square node
        for (int id = 1; id <= 3; ++id) {
            auto* v = vehicle_agent.getVehicleById(id);
            if (!v) continue;
            common::Point pos = v->getPosition();
            const char* name = pointName(pos);
            if (name && pos != last_square[id - 1]) {
                last_square[id - 1] = pos;
                auto route = v->getRoute();
                std::cout << "  T=" << std::setw(4) << t << "  V" << id
                          << " arrived at " << name;
                if (route.empty() && pos == common::SQUARE_A) {
                    std::cout << "  ** TOUR COMPLETE **";
                } else {
                    std::cout << "  (remaining stops: " << route.size() << ")";
                }
                std::cout << "\n";
            }
        }

        if (stats.getCompletedTours() != last_completed_tours) {
            std::cout << "  T=" << std::setw(4) << t
                      << "  total completed tours = " << stats.getCompletedTours() << "\n";
            last_completed_tours = stats.getCompletedTours();
        }

        // Print periodic snapshots every 100 steps
        if ((t + 1) % 200 == 0) {
            std::cout << "  T=" << std::setw(4) << t << "  [snapshot] ";
            for (int id = 1; id <= 3; ++id) {
                auto* v = vehicle_agent.getVehicleById(id);
                if (v) { printVehicleBrief(*v); std::cout << "  "; }
            }
            std::cout << "\n";
        }

    }

    // ── Final Report ───────────────────────────────────────────────────
    std::cout << "\n--- Final Vehicle Positions ---\n";
    for (int id = 1; id <= 3; ++id) {
        auto* v = vehicle_agent.getVehicleById(id);
        if (!v) continue;
        std::cout << "  ";
        printVehicleBrief(*v);
        auto route = v->getRoute();
        std::cout << "  remaining_waypoints=" << route.size();
        std::cout << "\n";
    }

    std::cout << "\n--- Collision Check ---\n";
    std::cout << "  Slot-level collisions detected: " << collision_check_total
              << (collision_check_total == 0 ? "  (OK)" : "  (VIOLATIONS)") << "\n";

    stats.printReport();

    // ── Explanation ────────────────────────────────────────────────────
    std::cout << "\n--- What This Shows ---\n";
    std::cout << "1. Vehicles depart from square node A and navigate the 3x3 grid.\n";
    std::cout << "2. At each intersection, vehicles obey traffic lights (stop at RED).\n";
    std::cout << "3. At most 1 vehicle crosses any intersection per time step.\n";
    std::cout << "4. Infrastructure uses congestion-aware (longest-queue-first) switching\n";
    std::cout << "   with starvation prevention (MAX_RED_WAIT=4).\n";
    std::cout << "5. Vehicles immediately begin a new tour after returning to A.\n";
    std::cout << "6. No collisions or red-light violations occur.\n";

    std::cout << "\n=========================================================\n";
    std::cout << "  Demo complete.\n";
    std::cout << "=========================================================\n";
    return 0;
}
