username = input("---> Enter your username: ")
# username = "399076724"

randomStr = "cRVlg" # random string
newStr = ''

for i in range(0, len(username)): 
    if i > 1:
        if i > 3:
            newStr += randomStr[8-i]
        else:
            newStr += username[i+2]
    else:
        newStr += username[i+5]

print("(+) New generated string: " + newStr)

pwd = ''

i = 0
while True:    
    v3 = len(username)
    if v3 <= i:
        break
    v22 = (ord(username[i]) + ord(newStr[i])) // 2
    pwd += chr(v22)
    i += 1

print("(+) Your generated password: " + pwd)