#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX 50

void gravity_simulation(int matrix[MAX][MAX], int n, int m) {
    for (int col = 0; col < m; col++) {
        int stack[MAX] = {0};
        int top = 0;

        // Collect all non-zero blocks in the column
        for (int row = 0; row < n; row++) {
            if (matrix[row][col] != 0) {
                stack[top++] = matrix[row][col];
            }
        }

        // Fill the column from bottom up
        for (int row = n - 1; row >= 0; row--) {
            if (top > 0) {
                matrix[row][col] = stack[--top];
            } else {
                matrix[row][col] = 0;
            }
        }
    }
}

void remove_block(int matrix[MAX][MAX], int n, int m, int color_code) {
    for (int row = 0; row < n; row++) {
        for (int col = 0; col < m; col++) {
            if (matrix[row][col] == color_code) {
                matrix[row][col] = 0;
            }
        }
    }
}

bool can_access_target(int matrix[MAX][MAX], int n, int m, int target_color) {
    for (int row = 0; row < n; row++) {
        for (int col = 0; col < m; col++) {
            if (matrix[row][col] == target_color) {
                return true;
            }
        }
    }
    return false;
}

int count_blocks_to_remove(int matrix[MAX][MAX], int n, int m, int target_color) {
    int removals = 0;

    while (can_access_target(matrix, n, m, target_color)) {
        bool block_removed = false;

        // Remove blocks from rightmost column to left
        for (int col = m - 1; col >= 0; col--) {
            for (int row = n - 1; row >= 0; row--) {
                if (matrix[row][col] != 0 && matrix[row][col] != target_color) {
                    remove_block(matrix, n, m, matrix[row][col]);
                    gravity_simulation(matrix, n, m);
                    removals++;
                    block_removed = true;
                    break;
                }
            }
            if (block_removed) break;
        }
