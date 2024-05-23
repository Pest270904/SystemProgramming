def func(a1, a2):
    if (a1 <= 0): 
        return 0
    if (a2 == 1):
        return a2
    v3 = func(a1 - 1, a2) + a2
    return v3 + func(a1 - 2, a2)


for i in [2, 3]:
    print(f"i = {i} => func() = {func(9,i)}")