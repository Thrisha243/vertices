import math

def minimum_presses(n, m):
    """
    Calculate the minimum number of presses needed to paint the wall.
    
    Args:
        n (int): The size of the wall (N x N).
        m (int): The size of the brush (M x M).
        
    Returns:
        int: The minimum number of presses required.
    """
    # Calculate the number of presses needed along rows and columns
    presses_along_rows = math.ceil(n / m)
    presses_along_columns = math.ceil(n / m)
    
    # Total number of presses is the product of row and column presses
    total_presses = presses_along_rows * presses_along_columns
    return total_presses

# Example usage
if __name__ == "__main__":
    # Example inputs
    n = int(input("Enter the wall size (N): "))
    m = int(input("Enter the brush size (M): "))
    
    # Output the result
    result = minimum_presses(n, m)
    print(f"Minimum number of presses needed: {result}")
