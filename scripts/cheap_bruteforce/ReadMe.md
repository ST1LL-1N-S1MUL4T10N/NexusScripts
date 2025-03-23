let's break this down scientifically so you can understand just how long it might take for the script to brute-force a 12-character password with random guesses. We'll estimate it based on the number of combinations and the computational speed of your system.

### Estimation of Time Required:

1. **Character Set Size**:  
   Since you’re using a character set of digits (0-9) and lowercase letters (a-z), the total number of possible characters in the set is:
   - 10 digits + 26 lowercase letters = 36 possible characters per position.

2. **Total Combinations**:  
   For a 12-character password, the total number of possible combinations is:
   \[
   36^{12}
   \]
   This equals **473,838,133,832,161** combinations.

3. **Time per Attempt**:  
   The time it takes for the script to make one guess depends on a lot of factors:
   - CPU speed.
   - System load.
   - Python's execution speed.
   
   For estimation purposes, let’s assume your system can make about **100,000 guesses per second** (this is a rough number based on typical CPUs running simple Python scripts without GPU acceleration).

4. **Time Estimate Calculation**:  
   With **473,838,133,832,161** possible combinations and **100,000 guesses per second**, we can calculate the total time it would take to go through all combinations.

   \[
   \text{Time (in seconds)} = \frac{473,838,133,832,161}{100,000}
   \]
   This gives:
   \[
   \text{Time} \approx 4,738,381,338 \, \text{seconds}
   \]

5. **Convert to More Understandable Units**:
   - **Seconds to Minutes**:  
     \[
     4,738,381,338 \, \text{seconds} \div 60 \approx 78,972,689 \, \text{minutes}
     \]
   - **Minutes to Hours**:  
     \[
     78,972,689 \, \text{minutes} \div 60 \approx 1,315,795 \, \text{hours}
     \]
   - **Hours to Days**:  
     \[
     1,315,795 \, \text{hours} \div 24 \approx 54,824 \, \text{days}
     \]
   - **Days to Years**:  
     \[
     54,824 \, \text{days} \div 365 \approx 150 \, \text{years}
     \]

### Conclusion:

If you were to **brute-force a 12-character password with a random guess** (from a charset of 36 characters), and your system can handle about **100,000 guesses per second**, it would take **around 150 years** to try every single combination.

This illustrates just how infeasible brute-forcing a password of this length is in a realistic scenario.
