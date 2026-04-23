#ifndef POINT_H
#define POINT_H

#include <functional>

namespace common {
    struct Point {
        int x;
        int y;

        bool operator==(const Point& other) const {
            return x == other.x && y == other.y;
        }
        bool operator!=(const Point& other) const {
            return !(*this == other);
        }
        bool operator<(const Point& other) const {
            if (x != other.x) return x < other.x;
            return y < other.y;
        }
    };

    // Square node: only A is a square node (west of corner (0,0)).
    inline constexpr Point SQUARE_A{0, -1};

    // B, C, D are ordinary corner intersections on the 3x3 grid.
    inline constexpr Point N_B{2, 0};
    inline constexpr Point N_C{2, 2};
    inline constexpr Point N_D{0, 2};
}

// Hash function for Point (needed for unordered containers)
namespace std {
    template<>
    struct hash<common::Point> {
        std::size_t operator()(const common::Point& p) const {
            return std::hash<int>()(p.x) ^ std::hash<int>()(p.y);
        }
    };
}

#endif // POINT_H
