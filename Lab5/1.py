number = 2
res = "" + str(number)

for i in range(1,6):
    newNum = number + i # v2[i - 1] + i 
    res += ' ' + str(newNum)
    number = newNum

print(res)