#include <cassert>
#include <iostream>

#include "common/Grid.h"
#include "common/Vehicle.h"
#include "infrastructure/InfrastructureAgent.h"

using common::Grid;
using common::Intersection;
using common::Vehicle;
using common::Point;
using common::Direction;
using infrastructure::InfrastructureAgent;

static char lightChar(Intersection& intersection, int light) {
    if (!intersection.isLightEnabled(light)) {
        return '-';
    }
    if (intersection.isGreen(light)) {
        return 'G';
    }
    return 'R';
}

static int getSingleEnabledGreenLight(Grid& grid, int row, int col) {
    Intersection& intersection = grid.getIntersection(row, col);

    int green_light = -1;
    int green_count = 0;

    for (int light = 0; light < 4; ++light) {
        if (intersection.isLightEnabled(light) && intersection.isGreen(light)) {
            green_light = light;
            ++green_count;
        }
    }

    assert(green_count == 1 && "Each intersection should have exactly one enabled green light.");
    return green_light;
}

static const char* lightName(int light) {
    switch (light) {
        case 0: return "North";
        case 1: return "East";
        case 2: return "South";
        case 3: return "West";
        default: return "Unknown";
    }
}

static void printIntersectionState(Grid& grid, int row, int col) {
    Intersection& intersection = grid.getIntersection(row, col);

    std::cout << "(" << row << "," << col << ") "
              << "[N:" << lightChar(intersection, 0)
              << " E:" << lightChar(intersection, 1)
              << " S:" << lightChar(intersection, 2)
              << " W:" << lightChar(intersection, 3)
              << "]";
}

static void printGridState(Grid& grid, int step_number) {
    std::cout << "\n=============================\n";
    std::cout << "Traffic Light State After Step " << step_number << "\n";
    std::cout << "Legend: G = green, R = red, - = no road/light in that direction\n";
    std::cout << "Format: [N:? E:? S:? W:?]\n";
    std::cout << "=============================\n";

    for (int row = 0; row < 3; ++row) {
        for (int col = 0; col < 3; ++col) {
            printIntersectionState(grid, row, col);
            std::cout << "   ";
        }
        std::cout << "\n";
    }
}

// Test 1: Every intersection always has exactly one green light
void test_single_green_per_intersection() {
    std::cout << "Test 1: Single green per intersection...\n";
    Grid grid;
    InfrastructureAgent agent(grid);

    for (int step = 0; step < 20; ++step) {
        agent.step();
        for (int row = 0; row < 3; ++row) {
            for (int col = 0; col < 3; ++col) {
                getSingleEnabledGreenLight(grid, row, col);
            }
        }
    }
    std::cout << "  PASSED\n";
}

// Test 2: Starvation prevention — a direction can't stay red forever
void test_starvation_prevention() {
    std::cout << "Test 2: Starvation prevention...\n";
    Grid grid;
    InfrastructureAgent agent(grid);

    // Run enough steps for starvation guard to kick in (MAX_RED_WAIT = 6)
    // Track whether each enabled direction at (1,1) gets green at least once
    bool seen_green[4] = {false, false, false, false};

    for (int step = 0; step < 30; ++step) {
        agent.step();
        int green = getSingleEnabledGreenLight(grid, 1, 1);
        seen_green[green] = true;
    }

    // Intersection (1,1) has all 4 directions enabled
    Intersection& mid = grid.getIntersection(1, 1);
    for (int d = 0; d < 4; ++d) {
        if (mid.isLightEnabled(d)) {
            assert(seen_green[d] &&
                   "Starvation prevention: every enabled direction must get green within 30 steps.");
        }
    }
    std::cout << "  PASSED\n";
}

// Test 3: Congestion-aware — direction with more vehicles gets green
void test_congestion_aware_selection() {
    std::cout << "Test 3: Congestion-aware selection...\n";
    Grid grid;
    InfrastructureAgent agent(grid);

    // Place vehicles on the horizontal road approaching intersection (1,1) from the west
    // horizontal_roads[1][0], FORWARD direction (eastbound), approaching (1,1)
    // This is the West approach (direction 3)
    Vehicle v1(100, Point{1, 0});  // start at intersection, will place on road
    grid.addVehicle(v1);
    grid.moveVehicleToSlot(100, 0, 1, 0, 25, Direction::FORWARD);

    Vehicle v2(101, Point{1, 0});
    grid.addVehicle(v2);
    grid.moveVehicleToSlot(101, 0, 1, 0, 26, Direction::FORWARD);

    Vehicle v3(102, Point{1, 0});
    grid.addVehicle(v3);
    grid.moveVehicleToSlot(102, 0, 1, 0, 27, Direction::FORWARD);

    // Step the infra agent — should favor West approach (direction 3) at (1,1)
    // since it has 3 vehicles approaching, others have 0
    agent.step();

    int green = getSingleEnabledGreenLight(grid, 1, 1);
    // The vehicles are on horizontal_roads[1][0] FORWARD (eastbound)
    // They approach intersection (1,1) from the West → direction index 3
    // But wait: countApproachingVehicles for direction 3 (West) at (1,1)
    // looks at horizontal_roads[row][col-1] FORWARD = horizontal_roads[1][0] FORWARD
    assert(green == 3 && "Should give green to West (direction with most vehicles approaching).");

    std::cout << "  PASSED\n";
}

// Test 4: Visual output of congestion-aware behavior
void test_visual_output() {
    std::cout << "Test 4: Visual output...\n";
    Grid grid;
    InfrastructureAgent agent(grid);

    agent.step();
    printGridState(grid, 1);

    for (int row = 0; row < 3; ++row) {
        for (int col = 0; col < 3; ++col) {
            int green = getSingleEnabledGreenLight(grid, row, col);
            std::cout << "Intersection (" << row << "," << col
                      << ") active green = " << lightName(green) << "\n";
        }
    }

    // Run a few more steps to show cycling from starvation prevention
    for (int s = 2; s <= 10; ++s) {
        agent.step();
    }
    printGridState(grid, 10);

    std::cout << "  PASSED\n";
}

// Test 5: Corner congestion preference — vehicles at square node influence corner light
void test_corner_square_node_congestion() {
    std::cout << "Test 5: Corner square-node congestion preference...\n";
    Grid grid;
    InfrastructureAgent agent(grid);

    // Place 3 vehicles at SQUARE_A (west of (0,0))
    // These should count as approaching (0,0) from direction 3 (West)
    Vehicle v1(200, common::SQUARE_A);
    grid.addVehicle(v1);
    Vehicle v2(201, common::SQUARE_A);
    grid.addVehicle(v2);
    Vehicle v3(202, common::SQUARE_A);
    grid.addVehicle(v3);

    agent.step();

    // (0,0) has enabled directions: East(1), South(2), West(3)
    // West has 3 vehicles approaching from SQUARE_A, others have 0
    int green = getSingleEnabledGreenLight(grid, 0, 0);
    assert(green == 3 && "Corner (0,0) should give green to West (square-node A approach).");
    std::cout << "  PASSED\n";
}

// Test 6: MAX_RED_WAIT bound — no enabled direction stays red longer than MAX_RED_WAIT
void test_max_red_wait_bound() {
    std::cout << "Test 6: MAX_RED_WAIT starvation bound...\n";
    Grid grid;
    InfrastructureAgent agent(grid);

    // Track consecutive red streaks for all directions at two intersections:
    // (1,1) center (4 enabled) and (0,0) corner (3 enabled: E, S, W)
    struct TestTarget { int row; int col; const char* name; };
    TestTarget targets[] = {{1, 1, "center(1,1)"}, {0, 0, "corner(0,0)"}};

    const int MAX_RED_WAIT = 6;
    const int NUM_STEPS = 50;

    for (const auto& t : targets) {
        // Reset grid and agent for each target
        Grid tgrid;
        InfrastructureAgent tagent(tgrid);

        int red_streak[4] = {0, 0, 0, 0};
        int max_streak[4] = {0, 0, 0, 0};
        Intersection& inter = tgrid.getIntersection(t.row, t.col);

        for (int step = 0; step < NUM_STEPS; ++step) {
            tagent.step();
            int green = getSingleEnabledGreenLight(tgrid, t.row, t.col);
            for (int d = 0; d < 4; ++d) {
                if (!inter.isLightEnabled(d)) continue;
                if (d == green) {
                    red_streak[d] = 0;
                } else {
                    red_streak[d]++;
                    if (red_streak[d] > max_streak[d])
                        max_streak[d] = red_streak[d];
                }
            }
        }

        // When multiple directions starve simultaneously, only one is served
        // per tick. The worst-case red streak is MAX_RED_WAIT + (num_enabled - 2)
        // since each co-starved direction must wait its turn.
        int num_enabled = 0;
        for (int d = 0; d < 4; ++d)
            if (inter.isLightEnabled(d)) ++num_enabled;
        int max_allowed = MAX_RED_WAIT + std::max(0, num_enabled - 2);

        for (int d = 0; d < 4; ++d) {
            if (!inter.isLightEnabled(d)) continue;
            assert(max_streak[d] <= max_allowed &&
                   "No enabled direction should stay red longer than MAX_RED_WAIT + (N-2).");
        }
        std::cout << "  " << t.name << " max streaks: ";
        for (int d = 0; d < 4; ++d) {
            if (inter.isLightEnabled(d))
                std::cout << lightName(d) << "=" << max_streak[d] << " ";
        }
        std::cout << "OK\n";
    }
    std::cout << "  PASSED\n";
}

int main() {
    std::cout << "Running infrastructure agent tests...\n\n";

    test_single_green_per_intersection();
    test_starvation_prevention();
    test_congestion_aware_selection();
    test_visual_output();
    test_corner_square_node_congestion();
    test_max_red_wait_bound();

    std::cout << "\nAll infrastructure tests passed.\n";
    return 0;
}
