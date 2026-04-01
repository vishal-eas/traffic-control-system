#include "common/Road.h"

namespace common {
    Road::Road() {
        slots.fill(0);
    }

    int Road::getSlot(int index) const {
        if (index < 0 || index >= static_cast<int>(slots.size())) return -1;
        return slots[index];
    }

    bool Road::setSlot(int index, int vehicle_id) {
        if (index < 0 || index >= static_cast<int>(slots.size())) return false;
        if (slots[index] != 0) return false;
        slots[index] = vehicle_id;
        return true;
    }

    bool Road::clearSlot(int index) {
        if (index < 0 || index >= static_cast<int>(slots.size())) return false;
        slots[index] = 0;
        return true;
    }

    int Road::slotCount() const {
        return static_cast<int>(slots.size());
    }

    bool Road::isSlotOccupied(int index) const {
        if (index < 0 || index >= static_cast<int>(slots.size())) return false;
        return slots[index] != 0;
    }
}
