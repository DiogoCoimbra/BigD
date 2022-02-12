import sys

count=0
TAB_CHAR = '\t'

for line in sys.stdin:
    for token in line.strip().split(" /m"):
        if token: 
            count+= 1
print(count)



