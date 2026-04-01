#ifndef VEHICLE_H
#define VEHICLE_H

#include <vector> // IWYU pragma: keep
#include "common/Point.h"

namespace common {
    class Vehicle {
    public:
        Vehicle(int id, Point start_pos);

        void setRoute(const std::vector<Point>& route);
        const std::vector<Point>& getRoute() const;

        void move();
        Point getPosition() const;
        void setPosition(const Point& pos);
        
        // New: Detailed position tracking
        struct DetailedPosition {
            Point current_intersection;  // Which intersection area
            int road_type;              // 0=horizontal, 1=vertical
            int road_row;               // Row index of road
            int road_col;               // Column index of road
            int slot;                   // Which slot on road (0-29)
            bool at_intersection;       // True if at intersection, false if on road
        };
        
        DetailedPosition getDetailedPosition() const;
        void setDetailedPosition(const DetailedPosition& pos);
        
        int getId() const { return id; }
        int getSpeed() const { return speed; }
        void setSpeed(int new_speed) { speed = new_speed; }

    private:
        int id;
        Point position;              // Current logical position (intersection)
        int speed;
        std::vector<Point> route;
        
        // New: Detailed position state
        DetailedPosition detailed_pos;
    };
}

#endif // VEHICLE_H
