username = input("---> Enter your username: ")
# username = "399076724"

v8 = "cRVlg" # random string
newStr = ''

for i in range(0, len(username)): 
    if i > 1:
        if i > 3:
            newStr += v8[8-i]
        else:
            newStr += username[i+2]
    else:
        newStr += username[i+5]

print("(+) New generated string: " + newStr)

from math import ceil

pwd = ''

i = 0
while True:    
    v3 = len(username)
    if v3 <= i:
        break
    v22 = ceil(float((ord(username[i]) + ord(newStr[i]))) // 2) 
    pwd += chr(v22)
    i += 1

print("(+) Your generated password: " + pwd)