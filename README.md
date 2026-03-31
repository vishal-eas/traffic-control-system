# Traffic Control System

A C++17 agent-based traffic control simulation system using a state-container architecture pattern.

## Architecture Overview

This system follows a **state-container pattern** where:

- **Grid** acts as the single source of truth for all system state
- **Agents** (VehicleAgent, InfrastructureAgent) read Grid state and update it through well-defined interfaces
- Clear separation of concerns ensures maintainability and extensibility

```
┌─────────────────────────────────────────┐
│           SHARED STATE                  │
│  ┌─────────────────────────────────────┐│
│  │         Grid (State Container)      ││
│  │  • Vehicle positions                ││
│  │  • Traffic light states             ││
│  │  • Road occupancy                   ││
│  └─────────────────────────────────────┘│
└─────────────────────────────────────────┘
         ▲                   ▲
         │                   │
    READS STATE          UPDATES STATE
         │                   │
    ┌────┴────┐         ┌────┴──────────────┐
    │          │         │                   │
┌───────────┐  │   ┌──────────────┐  ┌──────────────┐
│ Vehicle   │  │   │Infrastructure│  │   Agents     │
│ Agent     │──┤   │    Agent     │  │              │
│           │  │   │              │  │ • Read Grid  │
│ Reads:    │  │   │ Reads:       │  │ • Update     │
│ • Positions   │  │ • Traffic    │  │   Grid via   │
│ • Routes  │  │   │   states     │  │   interfaces │
│ • Lights  │  │   │ • Congestion │  │              │
│           │  │   │              │  │              │
│ Decides:  │  │   │ Decides:     │  │              │
│ • Movement    │  │ • Signal     │  │              │
│ • Next slot   │  │   timing     │  │              │
│ • Entry to    │  │ • Priority   │  │              │
│   roads       │  │              │  │              │
└───────────┘  │   └──────────────┘  └──────────────┘
               │
               └────────────────────────────────────┘
```

## Core Components

### 1. **Grid (State Container)**

Located in `include/common/Grid.h` and `src/common/Grid.cpp`

The Grid is a **passive state holder** that:

#### State It Holds:
- **3×3 Intersection Grid**: 9 intersection points on a coordinate system (0,0) to (2,2)
- **Roads**: Horizontal and vertical roads connecting intersections
  - Each road has 30 slots for vehicle movement
  - Road types: 0 = horizontal, 1 = vertical
- **Vehicles**: Map of vehicle IDs to Vehicle objects with detailed position tracking
- **Traffic Lights**: 4 signals per intersection (North, South, East, West)

#### State Query Methods (Read-Only):
```cpp
// Vehicle queries
Vehicle* getVehicle(int vehicle_id);
const std::unordered_map<int, Vehicle>& getVehicles() const;
std::vector<int> getVehiclesOnRoad(int road_type, int row, int col) const;
std::vector<Point> getRoute(int vehicle_id) const;

// Road queries
Road* getRoad(int road_type, int row, int col);
bool isRoadSlotOccupied(int road_type, int row, int col, int slot) const;
bool canMoveToSlot(int vehicle_id, int road_type, int row, int col, int slot) const;

// Traffic light queries
LightState getLight(int row, int col, int light_index) const;
Intersection& getIntersection(int row, int col);
```

#### State Mutation Methods (Write):
```cpp
// Vehicle management
bool addVehicle(const Vehicle& vehicle);
bool moveVehicleToSlot(int vehicle_id, int road_type, int row, int col, int slot);
bool moveVehicleToIntersection(int vehicle_id, const Point& intersection);
void setRoute(int vehicle_id, const std::vector<Point>& route);

// Traffic control
void setLight(int row, int col, int light_index, LightState state);
```

### 2. **Data Models**

#### Point (Intersection Coordinate)
```cpp
struct Point {
    int x;  // Row (0-2)
    int y;  // Column (0-2)
};
```

#### Vehicle
- **Position**: Current intersection the vehicle is near
- **Detailed Position**: Precise location tracking
  - `at_intersection`: bool - true if waiting at intersection, false if on road
  - `current_intersection`: Point - which intersection area vehicle is in
  - `road_type`: int - 0 (horizontal) or 1 (vertical)
  - `road_row`, `road_col`: coordinates of the road
  - `slot`: position on road (0-29)
- **Route**: Vector of Point waypoints to navigate
- **Speed**: Vehicle speed (currently 1 slot per time step)

#### Road
- **30 Slots**: Array-based storage (0 = empty, >0 = vehicle_id)
- **Methods**: `setSlot()`, `clearSlot()`, `isSlotOccupied()`

#### Intersection
- **4 Traffic Lights**: North (0), South (2), East (1), West (3)
- **Light States**: GREEN or RED
- **Methods**: `setGreenLight()`, `isGreen()`, `isLightEnabled()`

### 3. **VehicleAgent (Movement Decision Maker)**

Located in `include/vehicle/VehicleAgent.h` and `src/vehicle/VehicleAgent.cpp`

#### Responsibilities:
1. **Add vehicles** to the simulation
2. **Update routes** based on congestion (future enhancement)
3. **Make movement decisions** by:
   - Reading Grid state (positions, routes, traffic lights)
   - Determining valid moves (is next slot free? is light green?)
   - Updating Grid state through Grid's mutation methods

#### Algorithm:

**Phase 1: Process Vehicles at Intersections**
```
For each vehicle at intersection:
  1. Read next waypoint from route
  2. Determine target road and direction
  3. Check if traffic light is GREEN
  4. If green AND first road slot is free:
     → Call grid.moveVehicleToSlot(vehicle, road, 0)
  5. Else: Vehicle waits at intersection (blocked)
```

**Phase 2: Process Vehicles on Roads (Slot-by-Slot Movement)**
```
For each road:
  1. Get all vehicles on road, sorted by slot (highest first)
  2. For each vehicle (in order):
     - If not at end of road:
       Check if next slot is free
       If free: Move vehicle forward one slot
       Else: Vehicle stays (blocked by vehicle ahead)
     - If at end of road (slot 29):
       Move vehicle to next intersection
       Remove first waypoint from route
```

**Key Features:**
- Vehicles cannot pass each other on roads
- Traffic lights control intersection entry
- Vehicles wait at intersections if entry is blocked
- Routes are followed sequentially

### 4. **InfrastructureAgent (Traffic Light Controller)**

Located in `include/infrastructure/InfrastructureAgent.h` and `src/infrastructure/InfrastructureAgent.cpp`

#### Responsibilities:
1. **Read Grid state** to understand traffic conditions
2. **Update traffic lights** at intersections

#### Current Algorithm: Simple Cycle Strategy
```
For each intersection:
  1. Find all enabled lights
  2. Rotate which light is green every 2 time steps
  3. Update Grid state via grid.setLight()
```

#### Future Enhancements:
- Read vehicle queue lengths on roads
- Adjust light timing based on congestion
- Implement priority for certain directions
- Adaptive signal timing

## System State Flow

**Time Step Execution:**

```
1. VehicleAgent::step()
   ├─ updateRoutePlanning()
   │  └─ Plan/adjust routes based on grid state
   └─ updateMovement()
      ├─ Phase 1: Intersections → Roads
      │  └─ Vehicles read lights, enter roads if green
      └─ Phase 2: Roads → Intersections
         └─ Vehicles move forward on roads
         
2. InfrastructureAgent::step()
   ├─ updateLights()
   │  └─ Read grid state, update traffic signals
   │
   └─ State mutation happens here
```

## Coordinate System

**Grid Layout:**
```
       Y (columns)
       0   1   2
    ╔═══╦═══╦═══╗
  X ║(0,0)|(0,1)|(0,2)║
  0 ╠═══╬═══╬═══╣
    ║───┼───┼───║
    ╠═══╬═══╬═══╣
  1 ║(1,0)|(1,1)|(1,2)║
    ╠═══╬═══╬═══╣
    ║───┼───┼───║
    ╠═══╬═══╬═══╣
  2 ║(2,0)|(2,1)|(2,2)║
    ╚═══╩═══╩═══╝
```

**Road Types:**
- **Horizontal (type 0)**: Connect (x,y) to (x,y+1)
- **Vertical (type 1)**: Connect (x,y) to (x+1,y)

**Light Indices at Each Intersection:**
- `0`: North (toward decreasing x)
- `1`: East (toward increasing y)
- `2`: South (toward increasing x)
- `3`: West (toward decreasing y)

## Movement Example

**Vehicle Route: (0,0) → (0,1) → (0,2)**

```
Time  Vehicle Position        State
────────────────────────────────────
0     (0,0) at intersection    Waiting for light

1     (0,0) at intersection    East light is RED, waiting

15    (0,0) at intersection    East light is GREEN
      (First slot of road available)

16    Road type 0, slot 0      Entered horizontal road
      (Moving from (0,0) to (0,1))

46    Road type 0, slot 29     At end of road
      (About to reach (0,1))

47    (0,1) at intersection    Reached waypoint
      Route updated to: (0,1) → (0,2)
      
48    (0,1) at intersection    East light is GREEN

49    Road type 0, slot 0      Entered next road
      (Moving from (0,1) to (0,2))

79    Road type 0, slot 29     At end of road

80    (0,2) at intersection    Reached destination
      Route is empty
```

## Building and Running

### Build System
- **CMake 3.15+** required
- **C++17** standard
- **Output**: Two executables in `build/` directory

### Build Commands
```bash
cd build
cmake ..
make
```

### Running Simulations

**Vehicle Simulation** (VehicleAgent + Grid + 3 test vehicles):
```bash
./vehicle_sim
```
Output shows vehicle positions at each time step:
```
Time Step 0: V3: (0, 0) V2: (0, 0) V1: (0, 0) 
Time Step 1: V3: (0, 0) V2: (0, 0) V1: (0, 0) 
...
Time Step 32: V3: (0, 1) V2: (0, 0) V1: (0, 0)
```

**Infrastructure Simulation** (InfrastructureAgent + Grid):
```bash
./infrastructure_sim
```
Output shows traffic light states at each intersection:
```
Time Step 0
Intersection (0,0) state:
  Light 0: GREEN
  Light 1: RED
  Light 2: RED
  Light 3: RED
```

## File Structure

```
traffic-control-system/
├── README.md                    # This file
├── CMakeLists.txt              # Build configuration
├── include/
│   ├── common/
│   │   ├── Grid.h              # State container
│   │   ├── Intersection.h       # Intersection with lights
│   │   ├── Road.h              # Road with 30 slots
│   │   ├── Vehicle.h           # Vehicle entity
│   │   ├── Point.h             # Coordinate type
│   │   ├── TrafficLight.h       # Light state enum
│   │   └── Protocol.h          # Shared types
│   ├── vehicle/
│   │   └── VehicleAgent.h       # Vehicle movement agent
│   └── infrastructure/
│       └── InfrastructureAgent.h # Traffic light controller
├── src/
│   ├── common/
│   │   ├── Grid.cpp            # State container implementation
│   │   ├── Intersection.cpp     # Intersection implementation
│   │   ├── Road.cpp            # Road implementation
│   │   ├── Vehicle.cpp         # Vehicle implementation
│   │   └── TrafficLight.cpp     # Light implementation
│   ├── vehicle/
│   │   ├── VehicleAgent.cpp     # Agent implementation
│   │   └── main.cpp            # Vehicle simulation entry point
│   └── infrastructure/
│       ├── InfrastructureAgent.cpp # Agent implementation
│       └── main.cpp             # Infrastructure simulation entry point
└── build/                       # Build output (after cmake)
```

## Key Design Patterns

### 1. **State-Container Pattern**
- Grid holds all system state
- Agents query state before deciding
- Agents update state through Grid interfaces
- Benefits: Centralized state, easy to debug, testable

### 2. **Agent Pattern**
- Independent decision-making entities
- Each agent has a specific responsibility
- Agents coordinate through shared Grid state
- Benefits: Extensible, composable, realistic

### 3. **Separation of Concerns**
- Grid: State only (no logic)
- VehicleAgent: Movement decisions only
- InfrastructureAgent: Signal decisions only
- Benefits: Clear responsibilities, maintainable

## Future Enhancements

### Short Term
- [ ] Adaptive traffic light timing based on queue length
- [ ] Priority lanes for emergency vehicles
- [ ] Vehicle acceleration/deceleration mechanics

### Medium Term
- [ ] A* pathfinding for optimal routes
- [ ] Congestion detection and avoidance
- [ ] Multiple vehicle types (cars, trucks, buses)
- [ ] Visualization of grid and vehicle movement

### Long Term
- [ ] Machine learning for traffic optimization
- [ ] Real-world traffic data integration
- [ ] Multi-city simulation
- [ ] Signal coordination across grid

## Testing

All compilation produces exit code 0 and simulations run successfully:
```bash
$ cd build && make && ./vehicle_sim
$ cd build && make && ./infrastructure_sim
```

Both simulations demonstrate:
- Vehicle movement through intersections and roads
- Traffic light cycling at all intersections
- Proper state updates in Grid
- Agent decision-making based on Grid state
