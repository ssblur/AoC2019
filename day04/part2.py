import re

start = 0
end = 999999
with open('input.txt', 'r') as f:
    value = f.read().split('-')
    start = int(value[0])
    end = int(value[1])

def checkPassword(password):
    consecutive = 0
    last = 0
    double = False
    for c in password:
        if int(c)<last:
            return False
        if int(c)==last:
            consecutive += 1
        else:
            if consecutive==1:
                double = True
            consecutive = 0
        last = int(c)
    return double or consecutive == 1

valid = 0
for i in range(start, end):
    password = str(i)
    if checkPassword(password):
        valid += 1

print(valid)