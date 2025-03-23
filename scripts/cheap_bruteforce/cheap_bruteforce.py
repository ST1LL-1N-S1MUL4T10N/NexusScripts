#!/usr/bin/env python3
import itertools
import time

def crack_password(target, charset):
    """
    Systematically generate and test all possible combinations of characters
    for a password of the same length as 'target' until the correct password is found.
    """
    length = len(target)
    attempts = 0
    start_time = time.time()

    # Iterate over all possible combinations of the given length
    for candidate in itertools.product(charset, repeat=length):
        guess = ''.join(candidate)
        attempts += 1

        # For large numbers of attempts, print status every 10,000 tries
        if attempts % 10000 == 0:
            print(f"Attempts: {attempts} - Current guess: {guess}", end='\r')

        if guess == target:
            end_time = time.time()
            print("\n-----------------------------------")
            print(f"Password found: {guess}")
            print(f"Total attempts: {attempts}")
            print(f"Time taken: {end_time - start_time:.2f} seconds")
            print("-----------------------------------")
            return guess

    print("Password not found within the given parameters.")
    return None

if __name__ == '__main__':
    # Define the character set: digits and lowercase letters
    charset = "0123456789abcdefghijklmnopqrstuvwxyz"

    # Only use this on test systems, Morty!
    target = input("Enter the target password (for testing only!): ").strip()

    # Start the cracking process
    crack_password(target, charset)
