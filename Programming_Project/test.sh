#!/bin/bash

echo -e "\n===Arguements===\n"

echo -n "Testing No Arguements = "
./Coursework.c > tmp
if grep -q "Usage: Coursework <mazefile>" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing 2 arguements = "
./Coursework.c a b > tmp
if grep -q "Usage: Coursework <mazefile>" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -e "\n===File Testing===\n"

echo -n "Valid File Test = "
./Coursework.c maze.txt > tmp
if grep -q "File maze.txt successfully loaded." tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Non-existing file test = "
./Coursework.c fakemaze.txt > tmp
if grep -q "Error: Incorrect filename" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "File has no "S" character = "
timeout 0.2s ./Coursework.c no_s_maze.txt > tmp
if grep -q "Error: File not in the correct format" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -m "File has no "E" character = "
timeout 0.2s ./Coursework.c no_e_maze.txt > tmp
if grep -q "Error: File not in the correct format" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "File has no "#" character = "
timeout 0.2s ./Coursework.c no_#_maze.txt > tmp
if grep -q "Error: File not in the correct format" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "File has no " " character = "
timeout 0.2s ./Coursework.c no_""_maze.txt > tmp
if grep -q "Error: File not in the correct format" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing height and width less than 5 = "
./Coursework.c two_smaller_maze.txt
if grep -q "Error: File not in the correct format" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing height and width greater than 100 = "
./Coursework.c two_larger_maze.txt
if grep -q "Error: File not in the correct format" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing height is less than 5 = "
./Coursework.c one_smaller_maze.txt
if grep -q "Error: File not in the correct format" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing height is greater than 100 = "
./Coursework.c one_larger_maze.txt
if grep -q "Error: File not in the correct format" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

# test if row and columns of file are same length

echo -e "\n===User Input===\n"

echo -n "Testing Invalid Inputs = "
echo "0" | timeout 0.2s ./Coursework.c maze.txt > tmp
if grep -q "Error: Invalid Input. Use WASD" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing "W" Input = "
echo "W" | timeout 0.2s ./Coursework.c movement_maze.txt > tmp
if grep -q "Shows X moved up" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing "A" Input = "
echo "A" | timeout 0.2s ./Coursework.c movement_maze.txt > tmp
if grep -q "Shows X moved left" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing "S" Input = "
echo "S" | timeout 0.2s ./Coursework.c movement_maze.txt > tmp
if grep -q "Shows X moved down" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing "D" Input = "
echo "D" | timeout 0.2s ./Coursework.c movement_maze.txt > tmp
if grep -q "Shows X moved right" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing "M" Input = "
echo "M" | timeout 0.2s ./Coursework.c maze.txt > tmp
if grep -q "???" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing "m" Input = "
echo -"m" | timeout 0.2s ./Coursework.c Data/maze.txt > tmp
if grep -q "Shows first line of map" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -e "\n===Interactions with maze===\n"
# first movement key then map function
# check if it shows X with respect to S

echo -n "Testing move through " " = "
echo "W" | timeout 0.2s ./Coursework.c movement_maze.txt > tmp
if grep -q "Shows X moved up" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing stop when # = "

if grep -q "???" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing Reaching E = "
# pre-made test data, moves left in maze to reach E
echo "S" | timeout 0.2s ./Coursework.c win_maze.txt > tmp
if grep -q "You have won" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

# 

rm -f tmp