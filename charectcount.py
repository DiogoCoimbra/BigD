import sys
from collections import Counter

my_str = "Mary had a little lamb"
counter = Counter(my_str)
print counter[sys.stdin]
