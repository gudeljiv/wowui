from _skills import skills
import sys

print(sys.argv[1])

wow_class = "warrior"
if sys.argv[1]:
    wow_class = sys.argv[1]

for skill in skills[wow_class]:
    print(skill)
