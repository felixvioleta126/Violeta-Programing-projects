Create 10 different standalone Java programs implementing the programming exercises for Programming Logic and Design (CpE 02), keeping the code optimized, concise, and understandable using standard control structures (decision, repetition, branching) and basic arrays.

Working directory: c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs
Integrity mode: demo
The team must NOT: Use pre-built libraries or frameworks for core functionality

## Requirements

### R1. Program 1: Arithmetic Sequence (`Program1.java`)
Write a function `createArithmeticSeq` that prompts the user to input two numbers, `first` and `diff`. The function creates a one-dimensional array of 16 elements ordered in an arithmetic sequence and outputs the sequence (e.g., if `first = 21` and `diff = 5`, the output is `21 26 31 36 41 46 51 56 61 66 71 76 81 86 91 96`). Include a `main` method to execute the function.

### R2. Program 2: Min/Max and Sorting of 5 Numbers (`Program2.java`)
Input 5 numbers from the user, determine the highest and lowest numbers, and display the entered numbers in both ascending and descending order. Include a `main` method.

### R3. Program 3: Number System Converter Using Arrays (`Program3.java`)
Accept a positive decimal value input from the user and convert it to one of the following number systems based on user selection:
1 – Decimal to Binary
2 – Decimal to Octal
3 – Decimal to Hexadecimal
Use arrays to form the newly converted number and output the result. Include a `main` method.

### R4. Program 4: Triangle Classification (`Program4.java`)
Accept the values of 3 sides from the user and determine whether the triangle is equilateral, isosceles, or scalene. Include a `main` method.

### R5. Program 5: Palindrome Number Checker (`Program5.java`)
Check whether an input number is a palindrome (e.g., 121 is a palindrome, 321 is not). Include a `main` method.

### R6. Program 6: Day of Year Calculation (`Program6.java`)
Accept month, day, and year as integers from the user and determine the day number (1 to 366) in the year (e.g., Jan 1, 1994 is day 1; Dec 31, 1993 is day 365; Dec 31, 1996 is day 366). Leap year rules: a year is a leap year if divisible by 4, except years divisible by 100 are leap years only if divisible by 400. Include a `main` method.

### R7. Program 7: Prime or Composite Checker (`Program7.java`)
Accept an integer from the user and determine whether it is prime or composite. Include a `main` method.

### R8. Program 8: Greatest Common Divisor (`Program8.java`)
Accept 2 integers from the user and output their Greatest Common Divisor (GCD). Include a `main` method.

### R9. Program 9: Daily High Temperatures Analysis (`Program9.java`)
Prompt the user to enter daily high temperature values dynamically from standard input. Count and print the number of hot days (high temperature >= 85), pleasant days (60 to 84), and cold days (< 60), and display the category of each temperature. Include a `main` method.

### R10. Program 10: Exam Scores and Grade Distribution (`Program10.java`)
Read a list of integer exam scores (in the range 0 to 100) from the user until a negative sentinel value (e.g., -1) is entered. Do not include the negative sentinel in the calculation. Output the total number of grades and the count of grades in each letter category: 90 to 100 = A, 80 to 89 = B, 70 to 79 = C, 60 to 69 = D, 0 to 59 = F. Include a `main` method.

### R11. Programming Logic & Control Structure Conventions
All programs must adhere to CpE 02 guidelines:
- Use standard Java control structures: sequence, selection/decision (`if`, `if-else`, `if-else if`, `switch`), repetition (`while`, `do-while`, `for`), and branching (`break`, `continue`, `return`).
- Use `{ }` block brackets, consistent indentation, and `==` for comparisons.
- Keep the code optimized, concise, and understandable using standard Java SE features (`Scanner`, standard arrays) without external libraries or frameworks for core functionality.
- Deliver each program as a separate standalone `.java` file with its own `main` method.

## Acceptance Criteria

### Compilation and File Structure
- [ ] All 10 programs are created in `c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs` as standalone files `Program1.java` through `Program10.java`.
- [ ] Every file compiles cleanly with `javac` without errors.

### Functional Verification
- [ ] Program 1: Calling `createArithmeticSeq` with `first = 21` and `diff = 5` creates an array of 16 elements and outputs `21 26 31 36 41 46 51 56 61 66 71 76 81 86 91 96`.
- [ ] Program 2: Given 5 numbers (e.g., 42, 17, 88, 5, 23), identifies min (5) and max (88), and prints both ascending (`5 17 23 42 88`) and descending (`88 42 23 17 5`) orders.
- [ ] Program 3: Given 14 and choice 1, outputs binary `1110`; choice 2 outputs octal `16`; choice 3 outputs hexadecimal `E`; conversions use array-based digit construction.
- [ ] Program 4: Correctly identifies equilateral (e.g., 5, 5, 5), isosceles (e.g., 5, 5, 3), and scalene (e.g., 3, 4, 5) triangles.
- [ ] Program 5: Correctly identifies palindromes (e.g., 121, 1221) and non-palindromes (e.g., 321, 1234).
- [ ] Program 6: Correctly computes day 1 for Jan 1 1994, day 365 for Dec 31 1993, day 366 for Dec 31 1996, and day 60 for Mar 1 2000 (leap year) vs Mar 1 1900 (non-leap year).
- [ ] Program 7: Correctly identifies prime numbers (e.g., 2, 7, 13) and composite numbers (e.g., 4, 9, 15).
- [ ] Program 8: Correctly outputs the GCD for input pairs (e.g., GCD of 54 and 24 is 6; GCD of 17 and 19 is 1).
- [ ] Program 9: Correctly reads temperatures dynamically from standard input, displays the category for each, and outputs the correct totals for hot (>=85), pleasant (60-84), and cold (<60) days (verifiable against the 25 sample temperatures: 55, 62, 68, 74, 59, 45, 41, 58, 60, 67, 65, 78, 82, 88, 91, 92, 90, 93, 87, 78, 79, 72, 68, 61, 59 -> 7 hot, 11 pleasant, 7 cold).
- [ ] Program 10: Given input `98 87 86 85 85 78 73 72 72 72 70 66 63 50 -1`, terminates at `-1` and outputs Total = 14, A = 1, B = 4, C = 6, D = 2, F = 1.
- [ ] An automated test harness or script verifies all 10 programs against the test cases with all checks passing.
