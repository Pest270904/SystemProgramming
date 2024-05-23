encoded = "Yrmzivwmxc Sj Mrjsvqexmsr Xiglrspskc"

origin_str = ""

for i in range(0, len(encoded)):
    v3 = ord(encoded[i])
    if (v3 <= 96 or v3 > 122) and (v3 <= 64 or v3 > 90):
        # Check if v3 is a digit
        if 47 < v3 <= 57:
            v3 = (v3 - 48 + 4) % 10 + 48
    else:
        # v3 is a letter
        if v3 <= 96:
            v2 = 65  # 'A'
        else:
            v2 = 97  # 'a'
        v3 = (v3 - v2 + 4) % 26 + v2
    origin_str += chr(v3)

print (origin_str)