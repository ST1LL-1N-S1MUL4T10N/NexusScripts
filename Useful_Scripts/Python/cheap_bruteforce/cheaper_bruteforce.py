#!/usr/bin/env python3
import os
from random import randint

# Input the password to attack
pas = input("Send the password: ")

# List of keys for generating the password guess
keys = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", 
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", 
        "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", 
        "w", "x", "y", "z"]

# Initialize the password guess
pwg = ""

# Start the attack loop
while(pwg != pas):
    pwg = ""
    for i in range(len(pas)):
        # Randomly select a character from keys and add to the guessed password
        guessPass = keys[randint(0, len(keys) - 1)]
        pwg = str(guessPass) + str(pwg)

    # Print the current password guess and the attack message
    print(pwg)
    print("Attacking... please wait!")
    
    # Clear the screen (works for Windows)
    os.system("cls")
    
# Print the final guessed password when it matches the input
print(f"The pass is: {pwg}")
