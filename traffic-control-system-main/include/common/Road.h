#ifndef ROAD_H
#define ROAD_H

#include <array>

namespace common {
    class Road {
    public:
        Road();

        int getSlot(int index) const;
        bool setSlot(int index, int vehicle_id);
        bool clearSlot(int index);
        int slotCount() const;
        bool isSlotOccupied(int index) const;

    private:
        // A road has 30 slots (0 = empty, >0 = vehicle_id)
        std::array<int, 30> slots;
    };
}

#endif // ROAD_H
