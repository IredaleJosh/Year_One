#!/bin/bash

echo -e "\n===Arguements===\n"

echo -n "Testing No Arguements = "
# No arguements should tell user the format of what they should type
./maze > tmp
if grep -q "Usage: maze <mazefile>" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -n "Testing 2 arguements = "
# code only takes a single arguement, the maze file, so test 2 means
# code recognises only 1 file is needed
# expected to tell user the formatting
./maze a b > tmp
if grep -q "Usage: maze <mazefile>" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -e "\n===File Testing===\n"

# tests that a file in the correct format is recognised as such by the code
# expected to tell user the file is loaded sucessfully
echo -n "Valid File Test = "
./maze Data/valid_maze.txt > tmp
if grep -q "File Data/valid_maze.txt successfully loaded." tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

# tests that it recognises a file has been inputted, but is
# not of the correct form, as it cannot be accessed
# expected to tell the user its the wrong filename
echo -n "Invalid file test = "
./maze Data/fake_maze.txt > tmp
if grep -q "Error: Incorrect filename" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

# File doesn't have a S or E or spaces for the user to move
# means it's in the incorrect format
# expected to tell the user its incorrect format 
echo -n "File has incorrect format = "
timeout 0.2s ./maze Data/bad_maze.txt > tmp
if grep -q "Error: File not in the correct format" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

# Tests either side as code checks for both
# one side too small means error
# expected to tell user maze is too small
echo -n "Testing height or width less than 5 = "
timeout 0.2s ./maze Data/two_smaller_maze.txt
if grep -q "Error: Maze is too small" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

# Test either side as code checks for both
# one side too big means error
# expected to tell user maze is too large
echo -n "Testing height or width greater than 100 = "
timeout 0.2s ./maze Data/two_larger_maze.txt
if grep -q "Error: Maze is too large" tmp;
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

# any other input that's not WASD or M/m is invalid
# tells user what inputs they 
echo -n "Testing Invalid Inputs = "
echo "P" | timeout 0.2s ./maze movement_maze.txt > tmp
if grep -q "Error: Please use WASD for movement or M/m for map" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

# player moves up when "W" pressed
# Expected to show X above S when checking map
echo -n "Testing "W" Input = "
timeout 0.2s ./maze movements_maze.txt < Inputs/w_input.in > tmp
if grep -q "##X## #" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

# player moves up when "W" pressed
# Expected to show X above S when checking map
echo -n "Testing "A" Input = "
timeout 0.2s ./maze movements_maze.txt < Inputs/a_input.in > tmp
if grep -q "#XS  ##" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

# player moves up when "W" pressed
# Expected to show X above S when checking map
echo -n "Testing "S" Input = "
timeout 0.2s ./maze movements_maze.txt < Inputs/s_input.in > tmp
if grep -q "# X#  #" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

# player moves up when "W" pressed
# Expected to show X above S when checking map
echo -n "Testing "D" Input = "
timeout 0.2s ./maze movements_maze.txt < Inputs/d_input.in > tmp
if grep -q "# SX ##" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

# check map is printed when "M" pressed
# expected to print first line of map
echo -n "Testing "M" Input = "
echo "M" | timeout 0.2s ./maze maze.txt > tmp
if grep -q "## ## #" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

# can either be upper or lower case for map function
# expected to output first line of map
echo -n "Testing "m" Input = "
echo "m" | timeout 0.2s ./maze maze.txt > tmp
if grep -q "## ## #" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

echo -e "\n===Interactions with maze===\n"
# each test moves one direction to reach wall, edge or E
# faster testing

# code checks if hit wall and tell user such
# Expected to print error telling user they hit a wall
echo -n "Testing stop when # = "
echo "A" | timeout 0.2s ./maze stop_maze.txt > tmp
if grep -q "Error: Cannot move through walls" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

# code checks if reached edge and tell user such
# Expected to print error telling user they reached an edge
echo -m "Testing when reach an edge = "
echo "W" | timeout 0.2s ./maze edge_maze.txt > tmp
if grep -q "Error: Cannot move outside the map" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

# code checks if player reaches E and tell user such
# Expected to print they won the game before closing
echo -n "Testing Reaching E = "
echo "D" | timeout 0.2s ./maze win_maze.txt > tmp
if grep -q "You have won" tmp;
then
    echo "Pass"
else
    echo "Fail"
fi

rm -f tmp