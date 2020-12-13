import re

start = 0
end = 999999
with open('input.txt', 'r') as f:
    value = f.read().split('-')
    start = int(value[0])
    end = int(value[1])

def checkPassword(password):
    double = False
    last = 0
    for c in password:
        if int(c)<last:
            return False
        if int(c)==last:
            double = True
        last = int(c)
    return double

valid = 0
for i in range(start, end):
    password = str(i)
    if checkPassword(password):
        valid += 1

print(valid)