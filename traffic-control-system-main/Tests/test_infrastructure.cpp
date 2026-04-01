#include <cassert>
#include <iostream>

#include "common/Grid.h"
#include "infrastructure/InfrastructureAgent.h"

using common::Grid;
using common::Intersection;
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

int main() {
    Grid grid;
    InfrastructureAgent agent(grid);

    std::cout << "Running infrastructure agent test...\n";

    agent.step();
    printGridState(grid, 1);

    for (int row = 0; row < 3; ++row) {
        for (int col = 0; col < 3; ++col) {
            int green = getSingleEnabledGreenLight(grid, row, col);
            std::cout << "Intersection (" << row << "," << col
                      << ") active green = " << lightName(green) << "\n";
        }
    }

    int first_green = getSingleEnabledGreenLight(grid, 1, 1);
    std::cout << "\nReference check at intersection (1,1): first green = "
              << lightName(first_green) << "\n";

    agent.step();
    printGridState(grid, 2);

    agent.step();
    printGridState(grid, 3);

    int second_green = getSingleEnabledGreenLight(grid, 1, 1);
    std::cout << "Reference check at intersection (1,1): second green = "
              << lightName(second_green) << "\n";

    assert(first_green != second_green &&
           "Green light should rotate after the cycle interval.");

    std::cout << "\nTest summary:\n";
    std::cout << "1. Every intersection had exactly one enabled green light.\n";
    std::cout << "2. The green direction at intersection (1,1) changed over time.\n";
    std::cout << "3. This confirms the simple cycling strategy is working.\n";

    std::cout << "\nAll infrastructure tests passed.\n";
    return 0;
}