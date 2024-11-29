# vertices
def normalize_polygon(vertices):
    """Normalize a polygon by finding the lexicographically smallest cyclic permutation."""
    n = len(vertices)
    cyclic_permutations = [vertices[i:] + vertices[:i] for i in range(n)]
    return min(cyclic_permutations)

def read_input():
    """Read input and return the parsed earrings data."""
    n = int(input())  
    earrings = []
    for _ in range(n):
        k = int(input())   
        vertices = [tuple(map(int, input().split())) for _ in range(k)]
        earrings.append(vertices)
    return earrings
def find_matching_earrings(earrings):
    """Find pairs of matching earrings and return their indices."""
    normalized = []
    for earring in earrings:
        normalized.append(normalize_polygon(earring))
    seen = {}
    matching_pairs = []
    for i, norm in enumerate(normalized):
        if norm in seen:
            matching_pairs.append(i + 1)
            if seen[norm] > 0:
            matching_pairs.append(seen[norm])
                seen[norm] = -1  # Mark as added
        else:
            seen[norm] = i + 1  # Store index (1-based)
    return sorted(matching_pairs)

def main():
    earrings = read_input()
    matching_pairs = find_matching_earrings(earrings)
    if matching_pairs:
        print(" ".join(map(str, matching_pairs)))
    else:
        print("No matching pairs found")

if _name_ == "_main_":
    main()






            
