#include <array>
#include <cassert>
#include <iostream>
#include <string>
#include <vector>

#include "common/Grid.h"
#include "common/SimulationStats.h"
#include "infrastructure/InfrastructureAgent.h"
#include "vehicle/VehicleAgent.h"

using common::Direction;
using common::Grid;
using common::LightState;
using common::Point;
using common::SimulationStats;
using infrastructure::InfrastructureAgent;
using vehicle::VehicleAgent;

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────

static void runStep(InfrastructureAgent& infra, VehicleAgent& va) {
    infra.step();
    va.step();
}

static void runSteps(int n, InfrastructureAgent& infra, VehicleAgent& va) {
    for (int i = 0; i < n; ++i) runStep(infra, va);
}

static int squareIndex(const Point& p) {
    if (p == common::SQUARE_A) return 0;
    if (p == common::SQUARE_B) return 1;
    if (p == common::SQUARE_C) return 2;
    if (p == common::SQUARE_D) return 3;
    return -1;
}

static void pass(const std::string& name) {
    std::cout << "  [PASS] " << name << "\n";
}

// ─────────────────────────────────────────────────────────────────────────────
// Test 1 (original): single vehicle reaches one square goal
// ─────────────────────────────────────────────────────────────────────────────
static void test_single_vehicle_reaches_goal() {
    Grid grid;
    VehicleAgent va(grid);
    InfrastructureAgent infra(grid);

    va.addVehicle(1, common::SQUARE_A);
    va.getVehicleById(1)->setRoute({common::SQUARE_B});

    bool moved_onto_road = false;
    bool reached_goal    = false;

    for (int step = 0; step < 800; ++step) {
        runStep(infra, va);

        auto* v = va.getVehicleById(1);
        assert(v && "Vehicle must remain in grid.");

        if (!v->getDetailedPosition().at_intersection) moved_onto_road = true;
        if (v->getPosition() == common::SQUARE_B && v->getRoute().empty()) {
            reached_goal = true;
            break;
        }
    }

    assert(moved_onto_road && "Vehicle must enter a road slot.");
    assert(reached_goal    && "Vehicle must reach SQUARE_B.");
    pass("single_vehicle_reaches_goal");
}

// ─────────────────────────────────────────────────────────────────────────────
// Test 2 (original): 3-vehicle full tour, all visit every square node
// ─────────────────────────────────────────────────────────────────────────────
static void test_three_vehicle_full_tour() {
    Grid grid;
    SimulationStats stats;
    VehicleAgent va(grid, &stats);
    InfrastructureAgent infra(grid);

    va.addVehicle(1, common::SQUARE_A);
    va.addVehicle(2, common::SQUARE_A);
    va.addVehicle(3, common::SQUARE_A);

    va.getVehicleById(1)->setRoute({common::SQUARE_B, common::SQUARE_C, common::SQUARE_D, common::SQUARE_A});
    va.getVehicleById(2)->setRoute({common::SQUARE_C, common::SQUARE_B, common::SQUARE_D, common::SQUARE_A});
    va.getVehicleById(3)->setRoute({common::SQUARE_D, common::SQUARE_B, common::SQUARE_C, common::SQUARE_A});

    std::array<std::array<bool,4>,3> visited{};
    for (auto& row : visited) row.fill(false);

    bool all_completed_once = false;
    for (int step = 0; step < 1500; ++step) {
        runStep(infra, va);
        for (int id = 1; id <= 3; ++id) {
            int sq = squareIndex(va.getVehicleById(id)->getPosition());
            if (sq >= 0) visited[id-1][sq] = true;
        }
        if (stats.getCompletedTours() >= 3) {
            all_completed_once = true;
            break;
        }
    }

    assert(all_completed_once && "All three vehicles must complete at least one full tour.");
    for (int id = 1; id <= 3; ++id) {
        for (int sq = 0; sq < 4; ++sq)
            assert(visited[id-1][sq] && "Must visit all four square nodes.");
    }
    pass("three_vehicle_full_tour");
}

// ─────────────────────────────────────────────────────────────────────────────
// Test 3: zero collisions throughout a full multi-vehicle run
// ─────────────────────────────────────────────────────────────────────────────
static void test_no_collisions_during_full_run() {
    Grid grid;
    SimulationStats stats;
    VehicleAgent va(grid, &stats);
    InfrastructureAgent infra(grid);

    va.addVehicle(1, common::SQUARE_A);
    va.addVehicle(2, common::SQUARE_A);
    va.addVehicle(3, common::SQUARE_A);

    va.getVehicleById(1)->setRoute({common::SQUARE_B, common::SQUARE_C, common::SQUARE_D, common::SQUARE_A});
    va.getVehicleById(2)->setRoute({common::SQUARE_C, common::SQUARE_B, common::SQUARE_D, common::SQUARE_A});
    va.getVehicleById(3)->setRoute({common::SQUARE_D, common::SQUARE_B, common::SQUARE_C, common::SQUARE_A});

    for (int step = 0; step < 1500; ++step) {
        runStep(infra, va);
        int c = grid.detectCollisions();
        assert(c == 0 && "Collision detected — two vehicles occupy the same road slot.");
    }

    assert(stats.getCollisions() == 0 && "SimulationStats must report zero collisions.");
    pass("no_collisions_during_full_run");
}

// ─────────────────────────────────────────────────────────────────────────────
// Test 4: SimulationStats records correct tour count and zero violations
// ─────────────────────────────────────────────────────────────────────────────
static void test_simulation_stats_accuracy() {
    Grid grid;
    SimulationStats stats;
    VehicleAgent va(grid, &stats);
    InfrastructureAgent infra(grid);

    va.addVehicle(1, common::SQUARE_A);
    va.addVehicle(2, common::SQUARE_A);
    va.addVehicle(3, common::SQUARE_A);

    va.getVehicleById(1)->setRoute({common::SQUARE_B, common::SQUARE_C, common::SQUARE_D, common::SQUARE_A});
    va.getVehicleById(2)->setRoute({common::SQUARE_C, common::SQUARE_B, common::SQUARE_D, common::SQUARE_A});
    va.getVehicleById(3)->setRoute({common::SQUARE_D, common::SQUARE_B, common::SQUARE_C, common::SQUARE_A});

    for (int step = 0; step < 1500; ++step) runStep(infra, va);

    assert(stats.getRedLightViolations() == 0 && "No red-light violations expected.");
    assert(stats.getCollisions()         == 0 && "No collisions expected.");
    assert(stats.getCompletedTours()     >= 3 && "Vehicles should complete repeated tours over the run.");
    assert(stats.getTotalSteps()         == 1500 && "Step count must match simulation length.");
    assert(stats.getThroughputPerHour()  > 0.0   && "Throughput must be positive.");
    pass("simulation_stats_accuracy");
}

// ─────────────────────────────────────────────────────────────────────────────
// Test 5: vehicle stops at red light and only moves when light turns green
// ─────────────────────────────────────────────────────────────────────────────
static void test_vehicle_stops_at_red_light() {
    Grid grid;
    VehicleAgent va(grid);
    // No InfrastructureAgent — we control lights manually.

    // Force all lights at (0,0) to RED.
    // East = light index 1 (the direction a vehicle from A would go first).
    // Leave them all RED for the first several steps.
    grid.setLight(0, 0, 1, LightState::GREEN); // set green first to satisfy setLight's RED fallback
    // Now keep cycling manually; we'll just force RED by never calling setLight GREEN.
    // Actually setLight(GREEN) is the only way to set green. So we set South green instead,
    // effectively keeping East red.
    grid.setLight(0, 0, 2, LightState::GREEN); // South is green, East stays RED

    va.addVehicle(1, common::SQUARE_A);
    va.getVehicleById(1)->setRoute({Point{0,0}, Point{0,1}}); // wants to go East from (0,0)

    // Step until it reaches (0,0)
    for (int i = 0; i < 10; ++i) va.step();
    auto* v = va.getVehicleById(1);

    // It should have reached (0,0) but East light is red, so it stays at intersection.
    // Give it a few more steps — it must not enter the eastbound road.
    bool stayed_at_intersection = true;
    for (int i = 0; i < 20; ++i) {
        va.step();
        auto pos = v->getDetailedPosition();
        if (!pos.at_intersection) {
            stayed_at_intersection = false;
            break;
        }
    }
    assert(stayed_at_intersection && "Vehicle must not enter road while East light is RED.");

    // Now turn East green — vehicle should enter road within a few steps.
    grid.setLight(0, 0, 1, LightState::GREEN);
    bool entered_road = false;
    for (int i = 0; i < 10; ++i) {
        va.step();
        if (!v->getDetailedPosition().at_intersection) { entered_road = true; break; }
    }
    assert(entered_road && "Vehicle must enter road once East light is GREEN.");
    pass("vehicle_stops_at_red_light");
}

// ─────────────────────────────────────────────────────────────────────────────
// Test 6: convoy — vehicles follow each other and never collide;
//         rear is blocked whenever it sees a vehicle ahead
// ─────────────────────────────────────────────────────────────────────────────
static void test_convoy_following_and_blocking() {
    // Part A: two vehicles one slot apart. The rear sees the front ahead and
    // must remain stopped until the road clears.
    {
        Grid grid;
        InfrastructureAgent infra(grid);
        VehicleAgent va(grid);

        common::Vehicle front(10, Point{0,0});
        common::Vehicle rear(11, Point{0,0});
        grid.addVehicle(front);
        grid.addVehicle(rear);
        grid.moveVehicleToSlot(10, 0, 0, 0, 10, Direction::FORWARD);
        grid.moveVehicleToSlot(11, 0, 0, 0,  9, Direction::FORWARD);

        for (int step = 0; step < 5; ++step) {
            runStep(infra, va);
            int fs = grid.getVehicle(10)->getDetailedPosition().slot;
            int rs = grid.getVehicle(11)->getDetailedPosition().slot;
            assert(fs == 11 + step && "Lead vehicle should keep advancing on a clear road.");
            assert(rs == 9 && "Rear vehicle must stay stopped while another vehicle is ahead.");
            assert(grid.detectCollisions() == 0 && "No collisions in convoy.");
        }
    }

    // Part B: front vehicle at slot 29, rear at slot 28.
    //         A competing vehicle on another road also targets the same intersection,
    //         so at most one of them crosses. If front is blocked, rear must also stay.
    {
        Grid grid;
        InfrastructureAgent infra(grid);
        VehicleAgent va(grid);

        // H[1][0]F: front=29, rear=28 — both want to reach intersection (1,1).
        // V[0][1]F: competitor=29 — also wants to reach (1,1).
        common::Vehicle hfront(20, Point{1,0});
        common::Vehicle hrear (21, Point{1,0});
        common::Vehicle vcomp (22, Point{0,1});
        grid.addVehicle(hfront);
        grid.addVehicle(hrear);
        grid.addVehicle(vcomp);
        grid.moveVehicleToSlot(20, 0, 1, 0, 29, Direction::FORWARD);
        grid.moveVehicleToSlot(21, 0, 1, 0, 28, Direction::FORWARD);
        grid.moveVehicleToSlot(22, 1, 0, 1, 29, Direction::FORWARD);

        runStep(infra, va);

        bool h_crossed = grid.getVehicle(20)->getDetailedPosition().at_intersection;
        bool v_crossed = grid.getVehicle(22)->getDetailedPosition().at_intersection;

        // At most one vehicle may cross the same intersection per step.
        assert((h_crossed ? 1 : 0) + (v_crossed ? 1 : 0) <= 1
               && "At most one vehicle may cross intersection per step.");

        // If horizontal front didn't cross, rear must still be at slot 28.
        if (!h_crossed) {
            assert(grid.getVehicle(21)->getDetailedPosition().slot == 28
                   && "Rear must be blocked while front is stuck at slot 29.");
        }
        assert(grid.detectCollisions() == 0 && "No collisions in blocking scenario.");
    }
    pass("convoy_following_and_blocking");
}

// ─────────────────────────────────────────────────────────────────────────────
// Test 7: square nodes remain distinct from intersections and use 2-slot links
// ─────────────────────────────────────────────────────────────────────────────
static void test_square_nodes_are_distinct_and_linked() {
    Grid grid;
    VehicleAgent va(grid);
    InfrastructureAgent infra(grid);

    assert(!grid.isIntersection(common::SQUARE_A));
    assert(!grid.isIntersection(common::SQUARE_B));
    assert(!grid.isIntersection(common::SQUARE_C));
    assert(!grid.isIntersection(common::SQUARE_D));

    for (int i = 0; i < 4; ++i) {
        const auto* road = grid.getSquareNodeRoad(i);
        assert(road && road->slotCount() == 2 && "Each square link must be modeled as a 2-slot road.");
    }

    va.addVehicle(1, common::SQUARE_A);
    va.getVehicleById(1)->setRoute({common::SQUARE_B});

    bool used_square_link = false;
    bool reached_b = false;

    for (int step = 0; step < 900; ++step) {
        runStep(infra, va);
        auto* v = va.getVehicleById(1);
        auto pos = v->getDetailedPosition();
        if (!pos.at_intersection && pos.road_type == 2) {
            used_square_link = true;
            assert((pos.slot == 0 || pos.slot == 1) && "Square-link roads must use one of the 2 square-link slots.");
        }
        if (v->getPosition() == common::SQUARE_B && v->getRoute().empty()) {
            reached_b = true;
            break;
        }
    }

    assert(used_square_link && "Vehicle should traverse a square-link road when leaving/entering a square node.");
    assert(reached_b && "Vehicle must reach square node B.");
    pass("square_nodes_are_distinct_and_linked");
}

// ─────────────────────────────────────────────────────────────────────────────
// Test 8: opposite-direction vehicles on the same road never collide
// ─────────────────────────────────────────────────────────────────────────────
static void test_opposite_direction_no_collision() {
    Grid grid;
    InfrastructureAgent infra(grid);
    VehicleAgent va(grid);

    // Place one vehicle going eastbound (FORWARD) and one going westbound (BACKWARD)
    // on the same horizontal road [0][0]. They should pass each other without colliding.
    common::Vehicle east(20, Point{0,0});
    common::Vehicle west(21, Point{0,1});
    grid.addVehicle(east);
    grid.addVehicle(west);
    // East starts near origin (slot 2), West starts near destination (slot 2 of BACKWARD lane).
    grid.moveVehicleToSlot(20, 0, 0, 0,  2, Direction::FORWARD);
    grid.moveVehicleToSlot(21, 0, 0, 0,  2, Direction::BACKWARD);

    for (int step = 0; step < 40; ++step) {
        runStep(infra, va);
        assert(grid.detectCollisions() == 0 && "Opposite-direction vehicles must not collide.");
    }
    pass("opposite_direction_no_collision");
}

// ─────────────────────────────────────────────────────────────────────────────
// Test 9: road traversal — single clear road takes exactly 30 steps
// ─────────────────────────────────────────────────────────────────────────────
static void test_road_traversal_takes_30_steps() {
    Grid grid;
    InfrastructureAgent infra(grid);
    VehicleAgent va(grid);

    // Place a vehicle at slot 0 of horizontal road [0][0] FORWARD.
    // No other vehicles — it should reach slot 29 in exactly 29 more steps,
    // then cross the intersection on the 30th step.
    common::Vehicle v(30, Point{0,0});
    grid.addVehicle(v);
    grid.moveVehicleToSlot(30, 0, 0, 0, 0, Direction::FORWARD);

    for (int step = 0; step < 29; ++step) {
        runStep(infra, va);
        auto pos = grid.getVehicle(30)->getDetailedPosition();
        assert(!pos.at_intersection && "Vehicle should still be on road.");
        assert(pos.slot == step + 1 && "Vehicle should advance exactly one slot per step.");
    }

    // Step 30: vehicle at slot 29 should cross to intersection (0,1).
    runStep(infra, va);
    auto final_pos = grid.getVehicle(30)->getDetailedPosition();
    assert(final_pos.at_intersection                          && "Vehicle should be at intersection.");
    assert((grid.getVehicle(30)->getPosition() == Point{0, 1}) && "Vehicle should arrive at (0,1).");
    pass("road_traversal_takes_30_steps");
}

// ─────────────────────────────────────────────────────────────────────────────
// Test 10: intersection crossing constraint — only one vehicle crosses per step
// ─────────────────────────────────────────────────────────────────────────────
static void test_intersection_crossing_constraint() {
    Grid grid;
    InfrastructureAgent infra(grid);
    VehicleAgent va(grid);

    // Place two vehicles at slot 29 of roads that both lead to intersection (1,1):
    //   - Vehicle A: horizontal road [1][0] FORWARD (eastbound, arrives at (1,1))
    //   - Vehicle B: vertical road [0][1] FORWARD (southbound, arrives at (1,1))
    common::Vehicle a(40, Point{1,0});
    common::Vehicle b(41, Point{0,1});
    grid.addVehicle(a);
    grid.addVehicle(b);
    grid.moveVehicleToSlot(40, 0, 1, 0, 29, Direction::FORWARD);
    grid.moveVehicleToSlot(41, 1, 0, 1, 29, Direction::FORWARD);

    // Run one step.
    runStep(infra, va);

    auto* va40 = grid.getVehicle(40);
    auto* va41 = grid.getVehicle(41);

    bool a_crossed = va40->getDetailedPosition().at_intersection;
    bool b_crossed = va41->getDetailedPosition().at_intersection;

    // Exactly one should have crossed (constraint: at most 1 per step).
    int crossed = (a_crossed ? 1 : 0) + (b_crossed ? 1 : 0);
    assert(crossed <= 1 && "At most 1 vehicle may cross an intersection per time step.");
    assert(grid.detectCollisions() == 0 && "No collisions at intersection.");
    pass("intersection_crossing_constraint");
}

// ─────────────────────────────────────────────────────────────────────────────
// Test 11: vehicle does not appear at invalid positions during a full tour
// ─────────────────────────────────────────────────────────────────────────────
static void test_vehicle_always_at_valid_position() {
    Grid grid;
    SimulationStats stats;
    VehicleAgent va(grid, &stats);
    InfrastructureAgent infra(grid);

    va.addVehicle(1, common::SQUARE_A);
    va.getVehicleById(1)->setRoute({common::SQUARE_B, common::SQUARE_C, common::SQUARE_D, common::SQUARE_A});

    for (int step = 0; step < 1500; ++step) {
        runStep(infra, va);

        auto* v = va.getVehicleById(1);
        assert(v && "Vehicle must remain in grid.");

        auto pos = v->getDetailedPosition();
        if (pos.at_intersection) {
            // Must be a valid intersection or square node.
            Point p = v->getPosition();
            assert(grid.isValidPoint(p) && "Vehicle position must be a valid point.");
        } else {
            // Must be on a valid road slot.
            assert((pos.road_type == 0 || pos.road_type == 1 || pos.road_type == 2)
                   && "Road type must be 0, 1, or 2.");
            assert((pos.direction == 0 || pos.direction == 1) && "Direction must be 0 or 1.");
            assert(grid.getRoad(pos.road_type, pos.road_row, pos.road_col) != nullptr
                   && "Vehicle must be on an existing road.");
            const auto* road = grid.getRoad(pos.road_type, pos.road_row, pos.road_col);
            assert(pos.slot >= 0 && pos.slot < road->slotCount() && "Slot must be valid for the current road.");
        }
    }
    pass("vehicle_always_at_valid_position");
}

// ─────────────────────────────────────────────────────────────────────────────
// Test 12: all 6 tour permutations of B,C,D complete successfully
// ─────────────────────────────────────────────────────────────────────────────
static void test_all_tour_permutations() {
    // The 6 orderings of visiting B, C, D before returning to A.
    const std::vector<std::vector<Point>> permutations = {
        {common::SQUARE_B, common::SQUARE_C, common::SQUARE_D, common::SQUARE_A},
        {common::SQUARE_B, common::SQUARE_D, common::SQUARE_C, common::SQUARE_A},
        {common::SQUARE_C, common::SQUARE_B, common::SQUARE_D, common::SQUARE_A},
        {common::SQUARE_C, common::SQUARE_D, common::SQUARE_B, common::SQUARE_A},
        {common::SQUARE_D, common::SQUARE_B, common::SQUARE_C, common::SQUARE_A},
        {common::SQUARE_D, common::SQUARE_C, common::SQUARE_B, common::SQUARE_A},
    };

    for (size_t i = 0; i < permutations.size(); ++i) {
        Grid grid;
        VehicleAgent va(grid);
        InfrastructureAgent infra(grid);

        va.addVehicle(1, common::SQUARE_A);
        va.getVehicleById(1)->setRoute(permutations[i]);

        bool completed = false;
        for (int step = 0; step < 1500; ++step) {
            runStep(infra, va);
            auto* v = va.getVehicleById(1);
            if (v->getPosition() == common::SQUARE_A && v->getRoute().empty()) {
                completed = true;
                break;
            }
        }
        assert(completed && "Tour permutation must complete within 1500 steps.");
        assert(grid.detectCollisions() == 0 && "No collisions in permutation tour.");
    }
    pass("all_tour_permutations");
}

// ─────────────────────────────────────────────────────────────────────────────
// Test 13: vehicles on different roads never interfere with each other
// ─────────────────────────────────────────────────────────────────────────────
static void test_independent_roads_no_interference() {
    Grid grid;
    InfrastructureAgent infra(grid);
    VehicleAgent va(grid);

    // Place one vehicle on each of the 4 horizontal roads (2 per row × 3 rows = 6 roads total)
    // and 4 vertical roads — use a representative subset.
    // H[0][0]F, H[1][0]F, V[0][0]F, V[0][1]F
    std::vector<std::tuple<int,int,int,int,Direction>> placements = {
        {50, 0, 0, 0, Direction::FORWARD},   // H[0][0] east
        {51, 0, 1, 0, Direction::FORWARD},   // H[1][0] east
        {52, 1, 0, 0, Direction::FORWARD},   // V[0][0] south
        {53, 1, 0, 1, Direction::FORWARD},   // V[0][1] south
    };

    for (auto& [id, rt, row, col, dir] : placements) {
        Point start = (rt == 0) ? Point{row, col} : Point{row, col};
        common::Vehicle v(id, start);
        grid.addVehicle(v);
        grid.moveVehicleToSlot(id, rt, row, col, 0, dir);
    }

    for (int step = 0; step < 30; ++step) {
        runStep(infra, va);
        assert(grid.detectCollisions() == 0 && "No collisions across independent roads.");
    }
    pass("independent_roads_no_interference");
}

// ─────────────────────────────────────────────────────────────────────────────
// Test 14: vehicles repeat their configured tour instead of resetting to one
// hard-coded order after the first completion
// ─────────────────────────────────────────────────────────────────────────────
static void test_vehicle_reuses_configured_tour_template() {
    Grid grid;
    SimulationStats stats;
    VehicleAgent va(grid, &stats);
    InfrastructureAgent infra(grid);

    va.addVehicle(1, common::SQUARE_A);
    va.getVehicleById(1)->setRoute(
        {common::SQUARE_D, common::SQUARE_C, common::SQUARE_B, common::SQUARE_A});

    bool completed_first_tour = false;
    bool saw_second_tour_depart_for_d = false;

    for (int step = 0; step < 2500; ++step) {
        runStep(infra, va);
        auto* v = va.getVehicleById(1);
        assert(v && "Vehicle must remain in grid.");

        if (!completed_first_tour && stats.getCompletedTours() >= 1) {
            completed_first_tour = true;
        }

        if (completed_first_tour && v->getPosition() == Point{0, 0}) {
            const auto route = v->getRoute();
            for (const auto& waypoint : route) {
                if (squareIndex(waypoint) >= 0) {
                    if (waypoint == common::SQUARE_D) {
                        saw_second_tour_depart_for_d = true;
                    }
                    break;
                }
            }
            if (saw_second_tour_depart_for_d) break;
        }
    }

    assert(completed_first_tour && "Vehicle should complete its first configured tour.");
    assert(saw_second_tour_depart_for_d &&
           "Vehicle should start its next tour using the same configured square-node order.");
    pass("vehicle_reuses_configured_tour_template");
}

// ─────────────────────────────────────────────────────────────────────────────
// Main
// ─────────────────────────────────────────────────────────────────────────────
int main() {
    std::cout << "Running vehicle agent tests...\n\n";

    test_single_vehicle_reaches_goal();
    test_three_vehicle_full_tour();
    test_no_collisions_during_full_run();
    test_simulation_stats_accuracy();
    test_vehicle_stops_at_red_light();
    test_convoy_following_and_blocking();
    test_square_nodes_are_distinct_and_linked();
    test_opposite_direction_no_collision();
    test_road_traversal_takes_30_steps();
    test_intersection_crossing_constraint();
    test_vehicle_always_at_valid_position();
    test_all_tour_permutations();
    test_independent_roads_no_interference();
    test_vehicle_reuses_configured_tour_template();

    std::cout << "\nAll vehicle tests passed.\n";
    return 0;
}
