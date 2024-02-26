#!/bin/bash

echo -e "\n===Arguements==="

echo -n "Testing No Arguements = "

if grep -q "" temp;
then
    echo "Pass"
else
    echo "Fail"

# Test Data
# check arguement count is 0
# check aruement count is 2

# check non-existent file
# check maze contains S 
# check maze contains E
# check maze contains " "
# check maze contains "#"

# check user input is W moves up
# check user input is A moves left
# check user input is S moves right
# check user input is D moves down
# check for incorect user input - Not WASD

# check player goes thru " "
# check player cannot go thru "#"
# check player player make valid move but cannot move due to "wall"

