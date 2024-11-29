def rotate_layer(matrix, row, col, size, layer, k):
    """
    Rotates a single layer of a sub-matrix either clockwise or counterclockwise and updates the letters as per rules.
    """
    layer_elements = []

    # Extract layer elements
    # Top row
    for j in range(col + layer, col + size - layer):
        layer_elements.append(matrix[row + layer][j])
    # Right column
    for i in range(row + layer + 1, row + size - layer):
        layer_elements.append(matrix[i][col + size - layer - 1])
    # Bottom row
    for j in range(col + size - layer - 2, col + layer - 1, -1):
        layer_elements.append(matrix[row + size - layer - 1][j])
    # Left column
    for i in range(row + size - layer - 2, row + layer, -1):
        layer_elements.append(matrix[i][col + layer])

    # Determine rotation direction and shift
    num_elements = len(layer_elements)
    if layer % 2 == 0:  # Even layer: clockwise
        shift = k % num_elements
    else:  # Odd layer: counterclockwise
        shift = -k % num_elements
    rotated_layer = layer_elements[shift:] + layer_elements[:shift]

    # Update letters
    for i in range(num_elements):
        char = rotated_layer[i]
        if layer % 2 == 0:  # Even layer: next letter
            rotated_layer[i] = chr((ord(char) - ord('A') + 1) % 26 + ord('A'))
        else:  # Odd layer: previous letter
            rotated_layer[i] = chr((ord(char) - ord('A') - 1) % 26 + ord('A'))

    # Place back the rotated and updated layer elements
    index = 0
    # Top row
    for j in range(col + layer, col + size - layer):
        matrix[row + layer][j] = rotated_layer[index]
        index += 1
    # Right column
    for i in range(row + layer + 1, row + size - layer):
        matrix[i][col + size - layer - 1] = rotated_layer[index]
        index += 1
    # Bottom row
    for j in range(col + size - layer - 2, col + layer - 1, -1):
        matrix[row + size - layer - 1][j] = rotated_layer[index]
        index += 1
    # Left column
    for i in range(row + size - layer - 2, row + layer, -1):
        matrix[i][col + layer] = rotated_layer[index]
        index += 1


def process_query(matrix, n, row, col, size):
    """
    Processes a single query by applying the rules for each layer of the specified sub-matrix.
    """
    num_layers = size // 2
    for layer in range(num_layers):
        rotate_layer(matrix, row, col, size, layer, layer + 1)


def matrix_to_string(matrix):
    """
    Converts the matrix to a single string by concatenating rows.
    """
    return ''.join(''.join(row) for row in matrix)


def main():
    # Input reading
    n = int(input().strip())
    matrix = [list(input().strip().split()) for _ in range(n)]
    q = int(input().strip())
    queries = [tuple(map(int, input().strip().split())) for _ in range(q)]

    # Process each query
    for row, col, size in queries:
        process_query(matrix, n, row, col, size)

    # Output the final matrix as a string
    print(matrix_to_string(matrix))


if __name__ == "__main__":
    main()
