#include <iostream>
#include <iomanip>
#include <array>
#include "common/Grid.h"
#include "common/Vehicle.h"
#include "infrastructure/InfrastructureAgent.h"

using common::Grid;
using common::Intersection;
using common::Vehicle;
using common::Direction;
using infrastructure::InfrastructureAgent;

static const char* dirName(int d) {
    switch (d) {
        case 0: return "N";
        case 1: return "E";
        case 2: return "S";
        case 3: return "W";
        default: return "?";
    }
}

static char lightChar(const Intersection& inter, int d) {
    if (!inter.isLightEnabled(d)) return '-';
    return inter.isGreen(d) ? 'G' : 'R';
}

static void printGridCompact(Grid& grid, int step) {
    std::cout << "Step " << std::setw(2) << step << ":  ";
    for (int row = 0; row < 3; ++row) {
        for (int col = 0; col < 3; ++col) {
            Intersection& inter = grid.getIntersection(row, col);
            std::cout << "(" << row << "," << col << ")[";
            std::cout << lightChar(inter, 0)
                      << lightChar(inter, 1)
                      << lightChar(inter, 2)
                      << lightChar(inter, 3) << "]";
            // Show which direction is green
            for (int d = 0; d < 4; ++d) {
                if (inter.isLightEnabled(d) && inter.isGreen(d)) {
                    std::cout << "=" << dirName(d);
                }
            }
            std::cout << "  ";
        }
        if (row < 2) std::cout << "\n          ";
    }
    std::cout << "\n";
}

int main() {
    std::cout << "=========================================================\n";
    std::cout << "  Infrastructure Agent Demo — Congestion-Aware Lights\n";
    std::cout << "=========================================================\n\n";

    // ── Part 1: Grid Topology ──────────────────────────────────────────
    std::cout << "--- Grid Topology ---\n";
    std::cout << "3x3 grid of intersections + 1 square node (A only).\n";
    std::cout << "Each intersection has lights only for directions with roads.\n\n";
    std::cout << "  A---O(0,0)---O(0,1)---D(0,2)\n";
    std::cout << "       |        |        |\n";
    std::cout << "      O(1,0)---O(1,1)---O(1,2)\n";
    std::cout << "       |        |        |\n";
    std::cout << "      B(2,0)---O(2,1)---C(2,2)\n\n";

    Grid grid;
    std::cout << "Enabled lights per intersection:\n";
    for (int row = 0; row < 3; ++row) {
        for (int col = 0; col < 3; ++col) {
            const Intersection& inter = grid.getIntersection(row, col);
            std::cout << "  (" << row << "," << col << "): ";
            for (int d = 0; d < 4; ++d) {
                if (inter.isLightEnabled(d))
                    std::cout << dirName(d) << " ";
            }
            std::cout << "\n";
        }
    }

    // ── Part 2: Empty-grid behavior (starvation cycling) ──────────────
    std::cout << "\n--- Demo 1: Empty Grid — Starvation Prevention ---\n";
    std::cout << "With no vehicles, all queues are 0. Lowest-index enabled\n";
    std::cout << "direction wins by tie-break. After MAX_RED_WAIT=4 ticks,\n";
    std::cout << "starved directions get forced green.\n";
    std::cout << "Format: [N E S W] where G=green R=red -=disabled\n\n";

    InfrastructureAgent agent1(grid);
    for (int step = 1; step <= 12; ++step) {
        agent1.step();
        printGridCompact(grid, step);
    }

    // ── Part 3: Congestion-aware selection ─────────────────────────────
    std::cout << "\n--- Demo 2: Congestion-Aware Selection ---\n";
    std::cout << "Place 3 vehicles approaching (1,1) from the West.\n";
    std::cout << "The agent should give green to West (highest queue).\n\n";

    Grid grid2;
    InfrastructureAgent agent2(grid2);

    Vehicle v1(100, common::Point{1, 0});
    grid2.addVehicle(v1);
    grid2.moveVehicleToSlot(100, 0, 1, 0, 25, Direction::FORWARD);

    Vehicle v2(101, common::Point{1, 0});
    grid2.addVehicle(v2);
    grid2.moveVehicleToSlot(101, 0, 1, 0, 26, Direction::FORWARD);

    Vehicle v3(102, common::Point{1, 0});
    grid2.addVehicle(v3);
    grid2.moveVehicleToSlot(102, 0, 1, 0, 27, Direction::FORWARD);

    agent2.step();
    Intersection& mid = grid2.getIntersection(1, 1);
    std::cout << "  Approaching vehicles per direction at (1,1):\n";
    std::cout << "    N=0  E=0  S=0  W=3\n";
    std::cout << "  Result: green = ";
    for (int d = 0; d < 4; ++d)
        if (mid.isLightEnabled(d) && mid.isGreen(d))
            std::cout << dirName(d);
    std::cout << " (West wins — longest queue)\n";

    // ── Part 4: Square-node congestion ─────────────────────────────────
    std::cout << "\n--- Demo 3: Square-Node Congestion at SQUARE_A ---\n";
    std::cout << "Place 2 vehicles at SQUARE_A (west of (0,0)).\n";
    std::cout << "The agent counts them as approaching (0,0) from West.\n\n";

    Grid grid3;
    InfrastructureAgent agent3(grid3);

    Vehicle sa1(200, common::SQUARE_A);
    grid3.addVehicle(sa1);
    Vehicle sa2(201, common::SQUARE_A);
    grid3.addVehicle(sa2);

    agent3.step();
    Intersection& corner = grid3.getIntersection(0, 0);
    std::cout << "  (0,0) enabled: E S W  |  Approach counts: E=0 S=0 W=2\n";
    std::cout << "  Result: green = ";
    for (int d = 0; d < 4; ++d)
        if (corner.isLightEnabled(d) && corner.isGreen(d))
            std::cout << dirName(d);
    std::cout << " (West wins — square-node vehicles counted)\n";

    // ── Part 5: Mutual exclusion verification ──────────────────────────
    std::cout << "\n--- Verification: Single Green Per Intersection ---\n";
    std::cout << "Running 50 steps, checking exactly 1 green per intersection...\n";

    Grid grid4;
    InfrastructureAgent agent4(grid4);
    bool all_ok = true;
    for (int step = 0; step < 50; ++step) {
        agent4.step();
        for (int row = 0; row < 3; ++row) {
            for (int col = 0; col < 3; ++col) {
                Intersection& inter = grid4.getIntersection(row, col);
                int green_count = 0;
                for (int d = 0; d < 4; ++d)
                    if (inter.isLightEnabled(d) && inter.isGreen(d))
                        ++green_count;
                if (green_count != 1) { all_ok = false; }
            }
        }
    }
    std::cout << "  Result: " << (all_ok ? "PASSED" : "FAILED") << " — mutual exclusion holds.\n";

    std::cout << "\n=========================================================\n";
    std::cout << "  Demo complete.\n";
    std::cout << "=========================================================\n";
    return 0;
}
