#ifndef ROAD_H
#define ROAD_H

#include <array>

namespace common {

    enum class Direction {
        FORWARD = 0,   // Horizontal: eastbound, Vertical: southbound
        BACKWARD = 1   // Horizontal: westbound, Vertical: northbound
    };

    class Road {
    public:
        Road();

        int getSlot(int index, Direction dir) const;
        bool setSlot(int index, int vehicle_id, Direction dir);
        bool clearSlot(int index, Direction dir);
        int slotCount() const;
        bool isSlotOccupied(int index, Direction dir) const;

        // Check if any vehicle exists ahead of current_slot in the given lane
        bool hasVehicleAhead(int current_slot, Direction dir) const;

    private:
        // Each road has two lanes: one per direction, 30 slots each
        // Slot 0 = near origin intersection, Slot 29 = near destination intersection
        std::array<int, 30> forward_slots;   // FORWARD direction lane
        std::array<int, 30> backward_slots;  // BACKWARD direction lane
    };
}

#endif // ROAD_H
