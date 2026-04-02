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
    };

    // Square node constants (corner placement)
    // A = west of (0,0), B = south of (2,0), C = east of (2,2), D = north of (0,2)
    inline constexpr Point SQUARE_A{0, -1};
    inline constexpr Point SQUARE_B{3, 0};
    inline constexpr Point SQUARE_C{2, 3};
    inline constexpr Point SQUARE_D{-1, 2};
}

// Hash function for Point (needed for unordered containers)
namespace std {
    template<>
    struct hash<common::Point> {
        size_t operator()(const common::Point& p) const {
            return hash<int>()(p.x) ^ (hash<int>()(p.y) << 16);
        }
    };
}

#endif // POINT_H
