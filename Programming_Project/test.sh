#!/bin/bash

echo -e "\n===Arguements===\n"

echo -n "Testing No Arguements = "
./maze > tmp
if grep -q "Usage: maze <mazefile>" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing 2 arguements = "
./maze a b > tmp
if grep -q "Usage: maze <mazefile>" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -e "\n===File Testing===\n"

echo -n "Valid File Test = "
./maze Data/valid_maze.txt > tmp
if grep -q "File Data/valid_maze.txt successfully loaded." tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Invalid file test = "
./maze Data/fake_maze.txt > tmp
if grep -q "Error: Incorrect filename" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "File has incorrect format = "
timeout 0.2s ./maze Data/bad_maze.txt > tmp
if grep -q "Error: File not in the correct format" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing height or width less than 5 = "
timeout 0.2s ./maze Data/two_smaller_maze.txt
if grep -q "Error: File not in the correct format" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing height or width greater than 100 = "
timeout 0.2s ./maze Data/two_larger_maze.txt
if grep -q "Error: File not in the correct format" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Test if rows or columns are the same length"
#test would check both rows and columns, as either means wrong format
timeout 0.2s ./maze Data/rows_columns_maze.txt
if grep -q "Error: File not in the correct format" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -e "\n===User Input===\n"
# use single "movements_maze.txt" to check if player
# moves in all 4 directions
# first do respective movement, then print map

echo -n "Testing Invalid Inputs = "
echo "P" | timeout 0.2s ./maze movement_maze.txt > tmp
if grep -q "Error: Please use WASD for movement" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing "W" Input = "
timeout 0.2s ./maze movements_maze.txt < Inputs/w_input.in > tmp
if grep -q "##X## #" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing "A" Input = "
timeout 0.2s ./maze movements_maze.txt < Inputs/a_input.in > tmp
if grep -q "#XS  ##" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing "S" Input = "
timeout 0.2s ./maze movements_maze.txt < Inputs/s_input.in > tmp
if grep -q "# X#  #" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing "D" Input = "
timeout 0.2s ./maze movements_maze.txt < Inputs/d_input.in > tmp
if grep -q "# SX ##" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing "M" Input = "
echo "M" | timeout 0.2s ./maze maze.txt > tmp
if grep -q "## ## #" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi
# can either be upper or lower case for map function
echo -n "Testing "m" Input = "
echo "m" | timeout 0.2s ./maze maze.txt > tmp
if grep -q "## ## #" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -e "\n===Interactions with maze===\n"

echo -n "Testing stop when # = "
# moves left to hit a wall - faster testing
echo "A" | timeout 0.2s ./maze stop_maze.txt > tmp
if grep -q "Error: Cannot move through walls" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -m "Testing when reach an edge = "
# moves up to hit edge - faster testing
echo "W" | timeout 0.2s ./maze edge_maze.txt > tmp
if grep -q "Error: Cannot move through walls" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing Reaching E = "
# moves right in test data maze to reach E - faster testing
echo "D" | timeout 0.2s ./maze win_maze.txt > tmp
if grep -q "You have won" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

rm -f tmp