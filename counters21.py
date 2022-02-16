import sys


TAB_CHAR = '\t'

for line in sys.stdin:
    for token in line.strip().split(" "):
        if token: 
            println(token + TAB_CHAR + '1')
            for token2 in line.strip("\n"):
                if token2:
                    println(token2 + TAB_CHAR + '1')
                    for token3 in line.strip().split():
                        if token3:
                            println(token3 + TAB_CHAR + '1')

