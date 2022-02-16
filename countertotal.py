import sys


TAB_CHAR = '\t'

for line in sys.stdin:
    for token in line.strip().split(" "):
        if token: 
            print("line" + TAB_CHAR + '1')
            for token2 in line.split("/n"):
                if token2:
                    print('word' + TAB_CHAR + '1')
                    for token3 in line:
                        if token3:
                            print('Characters' + TAB_CHAR + '1')
