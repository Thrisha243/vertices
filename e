#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define MAX_QUERIES 20

// Function to calculate the cost of moving the hands
int calculate_cost(int degrees, int clockwise, int first90_cost, int beyond90_cost) {
    if (degrees <= 90) {
        return degrees * first90_cost * clockwise;
    } else {
        return 90 * first90_cost * clockwise + (degrees - 90) * beyond90_cost * clockwise;
    }
}

// Function to calculate the absolute difference between two angles
int absolute_angle_difference(int angle1, int angle2) {
    int diff = abs(angle1 - angle2);
    return diff > 180 ? 360 - diff : diff;
}

int main() {
    // Input variables
    int hour, minute;
    int num_queries;
    int A, B, P, Q, X, Y;
    int queries[MAX_QUERIES];
    int total_cost = 0;

    // Reading initial time
    scanf("%d:%d", &hour, &minute);

    // Reading the number of queries
    scanf("%d", &num_queries);

    // Reading the costs
    scanf("%d %d", &A, &B);
    scanf("%d %d", &P, &Q);
    scanf("%d %d", &X, &Y);

    // Reading the angle queries
    for (int i = 0; i < num_queries; i++) {
        scanf("%d", &queries[i]);
    }

    // Initial angles of the hands
    int hour_angle = (hour % 12) * 30; // Each hour is 30 degrees
    int minute_angle = (minute % 60) * 6; // Each minute is 6 degrees

    // Process each query
    for (int i = 0; i < num_queries; i++) {
        int target_angle = queries[i];
        int current_angle = absolute_angle_difference(hour_angle, minute_angle);

        if (current_angle == target_angle) {
            // No cost if the angle is already formed
            continue;
        }

        // Calculate cost for all valid moves
        int min_cost = 1e9;

        // Move the hour hand clockwise and minute hand counterclockwise
        for (int h_clockwise = 0; h_clockwise <= 1; h_clockwise++) {
            for (int m_clockwise = 0; m_clockwise <= 1; m_clockwise++) {
                // Calculate new angles
                int new_hour_angle = (hour_angle + (h_clockwise ? 30 : -30)) % 360;
                if (new_hour_angle < 0) new_hour_angle += 360;

                int new_minute_angle = (minute_angle + (m_clockwise ? 6 : -6)) % 360;
                if (new_minute_angle < 0) new_minute_angle += 360;

                // Calculate the resulting angle
                int resulting_angle = absolute_angle_difference(new_hour_angle, new_minute_angle);

                // Check if it matches the target angle
                if (resulting_angle == target_angle) {
                    int hour_cost = calculate_cost(30, h_clockwise ? A : B, P, Q);
                    int minute_cost = calculate_cost(6, m_clockwise ? A : B, X, Y);
                    int total_move_cost = hour_cost + minute_cost;
                    if (total_move_cost < min_cost) {
                        min_cost = total_move_cost;
                    }
                }
            }
        }

        // Update the clock's hand positions and add to total cost
        total_cost += min_cost;
    }

    // Output the total cost
    printf("%d\n", total_cost);

    return 0;
}

