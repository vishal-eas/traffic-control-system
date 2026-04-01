#include "vehicle/VehicleAgent.h"
#include <iostream>
#include <vector>
#include <algorithm>

namespace vehicle {
    VehicleAgent::VehicleAgent(common::Grid& grid) 
        : grid(grid), time_step(0) {}

    void VehicleAgent::addVehicle(int vehicle_id, common::Point start_pos) {
        common::Vehicle vehicle(vehicle_id, start_pos);
        grid.addVehicle(vehicle);
    }

    void VehicleAgent::updateVehicles() {
        updateRoutePlanning();
        updateMovement();
    }

    void VehicleAgent::step() {
        updateVehicles();
        time_step++;
    }

    common::Vehicle* VehicleAgent::getVehicleById(int vehicle_id) {
        return grid.getVehicle(vehicle_id);
    }

    void VehicleAgent::updateRoutePlanning() {
        // TODO: Implement route planning based on congestion info
        // For now, vehicles follow pre-set routes
    }

    void VehicleAgent::updateMovement() {
        // Agent decision logic:
        // 1. For vehicles at intersections: check if can enter a road (light is green, first slot free)
        // 2. For vehicles on roads: move forward one slot if next slot is free
        
        auto& grid_vehicles = grid.getVehicles();
        
        // Process vehicles at intersections first
        for (const auto& kv : grid_vehicles) {
            int vehicle_id = kv.first;
            common::Vehicle* vehicle_ptr = grid.getVehicle(vehicle_id);
            if (!vehicle_ptr) continue;
            
            auto detailed_pos = vehicle_ptr->getDetailedPosition();
            
            if (detailed_pos.at_intersection) {
                // At intersection - decide which road to take toward next waypoint
                if (!vehicle_ptr->getRoute().empty()) {
                    common::Point current = vehicle_ptr->getPosition();
                    common::Point next = vehicle_ptr->getRoute().front();
                    
                    // Determine which road and direction to take
                    int road_type, road_row, road_col;
                    int light_index;
                    
                    if (current.y == next.y) {  // y same, x changes -> vertical movement (north/south)
                        road_type = 1;  // Vertical road
                        road_row = current.x;  // Row between intersections
                        road_col = current.y;  // Column index
                        light_index = (next.x > current.x) ? 2 : 0;  // South or North
                    } else if (current.x == next.x) {  // x same, y changes -> horizontal movement (east/west)
                        road_type = 0;  // Horizontal road
                        road_row = current.x;  // Row index
                        road_col = current.y;  // Column between intersections
                        light_index = (next.y > current.y) ? 1 : 3;  // East or West
                    } else {
                        continue;  // Invalid move
                    }
                    
                    // Agent decision: Check if traffic light is green AND first slot is free
                    if (grid.getLight(current.x, current.y, light_index) == common::LightState::GREEN) {
                        if (grid.canMoveToSlot(vehicle_id, road_type, road_row, road_col, 0)) {
                            // Move vehicle to first slot of the road
                            grid.moveVehicleToSlot(vehicle_id, road_type, road_row, road_col, 0);
                        }
                        // If can't move, vehicle stays at intersection (blocked by congestion)
                    }
                    // If light is red, vehicle waits at intersection
                }
            }
        }
        
        // Process vehicles on roads - slot-by-slot movement with jam propagation
        // Process each road separately to allow proper collision physics
        for (int road_type = 0; road_type < 2; ++road_type) {
            for (int row = 0; row < 3; ++row) {
                for (int col = 0; col < 2; ++col) {
                    // Get all vehicles on this road, sorted by slot descending (front to back)
                    std::vector<int> vehicles_on_road = grid.getVehiclesOnRoad(road_type, row, col);
                    
                    if (vehicles_on_road.empty()) continue;
                    
                    // Sort by slot descending (highest slot first - closest to destination)
                    std::sort(vehicles_on_road.begin(), vehicles_on_road.end(),
                        [this, road_type, row, col](int a, int b) {
                            auto pos_a = grid.getVehicle(a)->getDetailedPosition();
                            auto pos_b = grid.getVehicle(b)->getDetailedPosition();
                            return pos_a.slot > pos_b.slot;
                        });
                    
                    // Try to move each vehicle in order (process front vehicles first)
                    for (int vehicle_id : vehicles_on_road) {
                        common::Vehicle* vehicle_ptr = grid.getVehicle(vehicle_id);
                        if (!vehicle_ptr) continue;
                        
                        auto pos = vehicle_ptr->getDetailedPosition();
                        int current_slot = pos.slot;
                        
                        if (current_slot < 29) {
                            // Try to move to next slot
                            if (grid.canMoveToSlot(vehicle_id, road_type, row, col, current_slot + 1)) {
                                // Agent moves vehicle forward one slot
                                grid.moveVehicleToSlot(vehicle_id, road_type, row, col, current_slot + 1);
                            }
                            // If can't move, vehicle stays (blocked by vehicle ahead)
                        } else if (current_slot == 29) {
                            // At end of road - try to move to next intersection
                            common::Point next_intersection;
                            
                            if (road_type == 0) {  // Horizontal road
                                next_intersection = {row, col + 1};
                            } else {  // Vertical road (road_type == 1)
                                next_intersection = {row + 1, col};
                            }
                            
                            // Move vehicle to the next intersection
                            if (grid.moveVehicleToIntersection(vehicle_id, next_intersection)) {
                                // Remove the reached waypoint from route
                                auto route = vehicle_ptr->getRoute();
                                if (!route.empty()) {
                                    route.erase(route.begin());
                                    grid.setRoute(vehicle_id, route);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
