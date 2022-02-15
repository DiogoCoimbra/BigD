import sys

number_of_lines = 0
number_of_words = 0
number_of_characters = 0
TAB_CHAR = '\t'


for line in sys.stdin:
  line = line.strip("\n")


  words = line.strip().split(" ")
  number_of_lines += 1
  number_of_words += len(words)
  number_of_characters += len(line)


print("lines:" + TAB_CHAR + number_of_lines)
print("words:" + TAB_CHAR + number_of_words)
print("characters:" + TAB_CHAR + number_of_characters)
