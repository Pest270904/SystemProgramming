str_map = "maduiersnfotvbyl"
s1 = "sabres"

def find_possible_s_values(str_map, s1):
    # Convert str_map to array_3852
    array_3852 = list(str_map)
    
    possible_s_values = []
    
    for char in s1:
        # Find the indices in array_3852 that match the character
        indices = [i for i, x in enumerate(array_3852) if x == char]
        
        s_char_values = []
        for base in indices:
            for higher_bits in range(16):  # Higher bits can be 0-15 for 4 bits
                s_char_values.append((higher_bits << 4) | base)
        
        possible_s_values.append(s_char_values)
    
    return possible_s_values

possible_s_values = find_possible_s_values(str_map, s1)
for i, values in enumerate(possible_s_values):
    print(f"Possible values for s[{i}] corresponding to s1[{i}] = '{s1[i]}': {values}")