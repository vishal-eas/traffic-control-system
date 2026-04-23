#include <algorithm>
#include <cstdlib>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

#include "common/Grid.h"
#include "common/SimulationStats.h"
#include "infrastructure/InfrastructureAgent.h"
#include "vehicle/VehicleAgent.h"

namespace {
    using common::Point;

    std::vector<Point> routeForIndex(int vehicle_index, const std::string& mode) {
        static const std::vector<std::vector<Point>> kMixedRoutes = {
            {common::N_B, common::N_C, common::N_D, common::SQUARE_A},
            {common::N_C, common::N_B, common::N_D, common::SQUARE_A},
            {common::N_D, common::N_B, common::N_C, common::SQUARE_A},
            {common::N_B, common::N_D, common::N_C, common::SQUARE_A},
            {common::N_C, common::N_D, common::N_B, common::SQUARE_A},
            {common::N_D, common::N_C, common::N_B, common::SQUARE_A},
        };

        if (mode == "perimeter") {
            return {common::N_D, common::N_C, common::N_B, common::SQUARE_A};
        }
        if (mode == "balanced") {
            if ((vehicle_index % 2) == 0) {
                return {common::N_B, common::N_C, common::N_D, common::SQUARE_A};
            }
            return {common::N_D, common::N_C, common::N_B, common::SQUARE_A};
        }

        return kMixedRoutes[vehicle_index % static_cast<int>(kMixedRoutes.size())];
    }

    double throughputForWindow(int tours_completed, int steps) {
        if (steps <= 0) {
            return 0.0;
        }
        return (static_cast<double>(tours_completed) / static_cast<double>(steps * 2)) * 3600.0;
    }
}

int main(int argc, char** argv) {
    const int vehicle_count = (argc > 1) ? std::max(1, std::atoi(argv[1])) : 12;
    const int total_steps = (argc > 2) ? std::max(1, std::atoi(argv[2])) : 7200;
    const int warmup_steps = (argc > 3) ? std::max(0, std::atoi(argv[3])) : 1800;
    const std::string route_mode = (argc > 4) ? argv[4] : "mixed";

    common::Grid grid;
    common::SimulationStats stats;
    vehicle::VehicleAgent vehicle_agent(grid, &stats);
    infrastructure::InfrastructureAgent infra_agent(grid);

    for (int i = 0; i < vehicle_count; ++i) {
        const int vehicle_id = i + 1;
        vehicle_agent.addVehicle(vehicle_id, common::SQUARE_A);
        vehicle_agent.getVehicleById(vehicle_id)->setRoute(routeForIndex(i, route_mode));
    }

    int tours_at_warmup = 0;
    const int effective_warmup = std::min(warmup_steps, total_steps);

    for (int step = 0; step < total_steps; ++step) {
        infra_agent.step();
        vehicle_agent.step();

        if (step + 1 == effective_warmup) {
            tours_at_warmup = stats.getCompletedTours();
        }
    }

    const int measurement_steps = total_steps - effective_warmup;
    const int measurement_tours = stats.getCompletedTours() - tours_at_warmup;

    std::cout << std::fixed << std::setprecision(2);
    std::cout << "vehicles=" << vehicle_count
              << " route_mode=" << route_mode
              << " total_steps=" << total_steps
              << " warmup_steps=" << effective_warmup << "\n";
    std::cout << "completed_tours_total=" << stats.getCompletedTours()
              << " throughput_total=" << stats.getThroughputPerHour() << "\n";
    std::cout << "completed_tours_window=" << measurement_tours
              << " throughput_window=" << throughputForWindow(measurement_tours, measurement_steps) << "\n";
    std::cout << "collisions=" << stats.getCollisions()
              << " red_light_violations=" << stats.getRedLightViolations()
              << " opposite_direction_violations=" << stats.getOppositeDirectionViolations()
              << " u_turn_violations=" << stats.getUTurnViolations() << "\n";

    return 0;
}
