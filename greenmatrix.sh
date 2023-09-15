#!/bin/bash

# Define the characters to be used for the rain effect
CHARACTERS="0123456789"

# Set the terminal size
ROWS=$(tput lines)
COLS=$(tput cols)

# Set the font size and color (green)
FONT_SIZE="\e[1m"      # Larger font size
FONT_COLOR="\e[32m"    # Green text

# Initialize an array to store the columns
declare -a columns

# Initialize the columns with random characters
for ((i = 0; i < COLS; i++)); do
    columns[$i]="${CHARACTERS:$(($RANDOM % ${#CHARACTERS})):1}"
done

# Function to update a column with a new character
function update_column() {
    local col_index=$1
    columns[$col_index]="${CHARACTERS:$(($RANDOM % ${#CHARACTERS})):1}"
}

# Function to display the rain effect
function display_rain() {
    while true; do
        for ((col = 0; col < COLS; col++)); do
            # Randomly clear some characters
            if [ $((RANDOM % 5)) -eq 0 ]; then
                echo -ne "\033[$((RANDOM % ROWS));${col}H "
            else
                # Display the character and update it
                echo -ne "\033[$((RANDOM % ROWS));${col}H${FONT_COLOR}${FONT_SIZE}${columns[$col]}\e[0m"
                update_column $col
            fi
        done
        # Sleep briefly to control the speed of the rain
        sleep 0.05
    done
}

# Hide the cursor
tput civis

# Clear the screen
clear

# Start the rain effect
display_rain
