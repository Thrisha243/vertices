def max_substrings_removed(n, substrings, main_string):
    """
    Calculate the maximum number of substrings that can be removed from the main string.

    Args:
        n (int): The number of substrings.
        substrings (list of str): List of substrings to remove.
        main_string (str): The main string to process.

    Returns:
        int: Maximum number of substrings removed.
    """
    count = 0

    for sub in substrings:
      if sub in main_string:
            # Remove the first occurrence of the substring
            main_string = main_string.replace(sub, "", 1)
            count += 1  # Increment the removal count

    return count

if __name__ == "__main__":
    # Input number of substrings
    n = int(input().strip())

    # Input the substrings
    substrings = input().strip().split()

    # Input the main string
    main_string = input().strip()
  result = max_substrings_removed(n, substrings, main_string)
    print(result)
