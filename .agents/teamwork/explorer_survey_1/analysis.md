# Specification Analysis: Programs 1 to 5 (CpE 02 Programming Logic and Design)

## Executive Summary
This document provides the authoritative specification analysis for Programs 1 through 5 of the Programming Logic and Design (CpE 02) curriculum as required by `ORIGINAL_REQUEST.md`. Each program is designed to be a standalone Java application executing via its own `main` method, adhering strictly to core programming logic principles using sequence, selection, repetition, and basic arrays without relying on high-level library shortcuts (e.g., `Arrays.sort()`, `Integer.toBinaryString()`, `StringBuilder.reverse()`).

---

## Features Discovered

| # | Category | Feature | Description | Inputs | Outputs | Error Behavior | Discovered Via |
|---|----------|---------|-------------|--------|---------|----------------|----------------|
| 1 | Sequence & Arrays | `createArithmeticSeq` Definition | Function creating a 1D array of 16 elements in arithmetic progression | `first` (int/double), `diff` (int/double) | 16-element sequence printed space-delimited | Throws `InputMismatchException` on invalid tokens; zero diff creates uniform array | R1, Line 13-14, 61 |
| 2 | Sequence & Arrays | Interactive Main Invocation | `main` method prompts user or invokes `createArithmeticSeq` cleanly | User stdin: `first`, `diff` | Formatted prompt & sequence line | Scanner error on EOF or non-numeric input | R1, Line 14 |
| 3 | Array & Search | 5-Number Min/Max Search | Reads 5 numbers into array and computes lowest and highest values | 5 integer values from stdin | Displayed lowest (min) and highest (max) numbers | Non-integer input raises input error | R2, Line 16-17, 62 |
| 4 | Array & Sorting | Ascending Sort (Manual) | Sorts 5 numbers in ascending order without pre-built libraries | Array of 5 numbers | Numbers printed in non-decreasing order separated by spaces | Handled via standard comparison loops | R2, Line 16-17, 62 |
| 5 | Array & Sorting | Descending Sort (Manual) | Displays/sorts 5 numbers in descending order without pre-built libraries | Array of 5 numbers | Numbers printed in non-increasing order separated by spaces | Handled via reverse traversal or descending sort | R2, Line 16-17, 62 |
| 6 | Number Conversion | Interactive Conversion Menu | Menu allowing selection: 1=Binary, 2=Octal, 3=Hexadecimal | Choice integer (1, 2, or 3) | Formatted menu and prompt | Invalid choice outputs error notification | R3, Line 19-24, 63 |
| 7 | Number Conversion | Decimal to Binary (Array-based) | Repeated division by 2, storing remainder bits in an array | Non-negative decimal integer | Binary string/sequence representation | Division by base; 0 produces single '0' | R3, Line 21, 24 |
| 8 | Number Conversion | Decimal to Octal (Array-based) | Repeated division by 8, storing remainder digits in an array | Non-negative decimal integer | Octal string/sequence representation | Division by base; 0 produces single '0' | R3, Line 22, 24 |
| 9 | Number Conversion | Decimal to Hexadecimal (Array-based)| Repeated division by 16, mapping 10-15 to 'A'-'F' in array | Non-negative decimal integer | Hexadecimal representation with uppercase A-F | Division by base; 0 produces single '0' | R3, Line 23, 24 |
| 10 | Geometry Logic | Triangle Inequality Validation | Validates whether 3 positive sides can form a valid geometric triangle | Three sides $a, b, c$ | Boolean validity / error message if invalid | Rejects $\le 0$ sides and $a+b \le c$ violations | R4, Line 26-27, 64 |
| 11 | Geometry Logic | Equilateral Classification | Identifies triangle where all three sides are equal ($a == b == c$) | Three valid sides $a, b, c$ | "Equilateral triangle" output | N/A (tested after validity check) | R4, Line 26-27, 64 |
| 12 | Geometry Logic | Isosceles Classification | Identifies triangle where exactly two sides are equal | Three valid sides $a, b, c$ | "Isosceles triangle" output | N/A (tested after validity check) | R4, Line 26-27, 64 |
| 13 | Geometry Logic | Scalene Classification | Identifies triangle where all three sides are distinct | Three valid sides $a, b, c$ | "Scalene triangle" output | N/A (tested after validity check) | R4, Line 26-27, 64 |
| 14 | Arithmetic Logic | Palindrome Number Verification | Checks whether input integer reads identical forward and reverse | Integer number (e.g., long) | Result indicating whether number is a palindrome | Rejects negative numbers or denotes sign asymmetry | R5, Line 29-30, 65 |
| 15 | Arithmetic Logic | Single-Digit Palindrome Handling | Identifies single non-negative digits (0-9) as palindromes | Single digit integer (0-9) | Verified as palindrome | Non-numeric input raises error | R5, Line 29-30, 65 |

---

## Edge Cases

| # | Feature | Input | Observed Behavior |
|---|---------|-------|-------------------|
| 1 | Program 1: Arithmetic Seq | `first = 21`, `diff = 5` | Generates 16 elements: `21 26 31 36 41 46 51 56 61 66 71 76 81 86 91 96` |
| 2 | Program 1: Zero Diff | `first = 10`, `diff = 0` | Generates 16 identical elements: `10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10` |
| 3 | Program 1: Negative Diff | `first = 50`, `diff = -5` | Decreasing sequence: `50 45 40 35 30 25 20 15 10 5 0 -5 -10 -15 -20 -25` |
| 4 | Program 1: Negative First | `first = -30`, `diff = 4` | Transition through zero: `-30 -26 -22 -18 -14 -10 -6 -2 2 6 10 14 18 22 26 30` |
| 5 | Program 2: 5 Numbers | `42 17 88 5 23` | Min: `5`, Max: `88`, Ascending: `5 17 23 42 88`, Descending: `88 42 23 17 5` |
| 6 | Program 2: All Identical | `7 7 7 7 7` | Min: `7`, Max: `7`, Ascending: `7 7 7 7 7`, Descending: `7 7 7 7 7` |
| 7 | Program 2: All Negative | `-10 -50 -2 -15 -8` | Min: `-50`, Max: `-2`, Ascending: `-50 -15 -10 -8 -2`, Descending: `-2 -8 -10 -15 -50` |
| 8 | Program 2: Duplicates | `12 5 12 3 5` | Min: `3`, Max: `12`, Ascending: `3 5 5 12 12`, Descending: `12 12 5 5 3` |
| 9 | Program 3: Binary Conversion | Decimal `14`, Choice `1` | Output: `1110` (remainders 0, 1, 1, 1 reversed) |
| 10 | Program 3: Octal Conversion | Decimal `14`, Choice `2` | Output: `16` (remainders 6, 1 reversed) |
| 11 | Program 3: Hex Conversion | Decimal `14`, Choice `3` | Output: `E` (remainder 14 mapped to 'E') |
| 12 | Program 3: Zero Decimal | Decimal `0`, Choice `1/2/3` | Output: `0` (must not produce empty output or loop infinitely) |
| 13 | Program 3: Hex Boundaries | Decimal `255`, Choice `3` | Output: `FF` |
| 14 | Program 3: Invalid Menu Choice| Decimal `20`, Choice `5` | Outputs error message: "Invalid choice" |
| 15 | Program 3: Negative Input | Decimal `-10`, Choice `1` | Prompts error message: "Value must be positive" |
| 16 | Program 4: Equilateral | Sides `5, 5, 5` | Equilateral triangle |
| 17 | Program 4: Isosceles (Perm 1) | Sides `5, 5, 3` | Isosceles triangle |
| 18 | Program 4: Isosceles (Perm 2) | Sides `5, 3, 5` | Isosceles triangle |
| 19 | Program 4: Isosceles (Perm 3) | Sides `3, 5, 5` | Isosceles triangle |
| 20 | Program 4: Scalene | Sides `3, 4, 5` | Scalene triangle |
| 21 | Program 4: Degenerate Triangle| Sides `1, 2, 3` | Not a valid triangle ($1 + 2 = 3 \ngtr 3$) |
| 22 | Program 4: Impossible Triangle| Sides `1, 2, 10` | Not a valid triangle ($1 + 2 < 10$) |
| 23 | Program 4: Zero / Negative | Sides `0, 4, 4` or `-3, 4, 5` | Not a valid triangle (sides must be positive) |
| 24 | Program 5: Standard Palindrome| Input `121` | Palindrome |
| 25 | Program 5: Even-length Palindrome| Input `1221` | Palindrome |
| 26 | Program 5: Non-palindrome | Input `321` | Not a palindrome |
| 27 | Program 5: Trailing Zero | Input `10` or `1200` | Not a palindrome (reversed is `01` / `0021` -> 1 / 21) |
| 28 | Program 5: Single Digit | Input `7` or `0` | Palindrome |
| 29 | Program 5: Negative Number | Input `-121` | Not a palindrome (leading negative sign makes reversed `121-` asymmetrical) |

---

## Detailed Program Specifications

### 1. Program 1: Arithmetic Sequence (`Program1.java`)

#### 1.1 Interface and Method Signatures
- **Class**: `public class Program1`
- **Method Signature**:
  ```java
  public static int[] createArithmeticSeq(Scanner scanner)
  public static int[] createArithmeticSeq(int first, int diff)
  public static void main(String[] args)
  ```
  *Design Rationale*:
  - Providing `createArithmeticSeq(Scanner scanner)` satisfies the requirement to prompt the user directly inside the function.
  - Providing an overloaded pure function `createArithmeticSeq(int first, int diff)` returning `int[]` allows direct, robust automated testing without string scraping.
  - The function prints the 16 space-separated values to `System.out` and returns the populated 16-element array.

#### 1.2 Mathematical Formulation
- Array size: exactly 16 (`new int[16]`).
- For index $i \in [0, 15]$:
  $$\text{sequence}[i] = \text{first} + i \times \text{diff}$$
  Alternatively:
  $$\text{sequence}[0] = \text{first}$$
  $$\text{sequence}[i] = \text{sequence}[i - 1] + \text{diff} \quad \text{for } 1 \le i < 16$$

#### 1.3 Standard Prompts & Output Formatting
```
Enter the first number: 21
Enter the common difference: 5
Arithmetic Sequence:
21 26 31 36 41 46 51 56 61 66 71 76 81 86 91 96
```

---

### 2. Program 2: Min/Max and Sorting of 5 Numbers (`Program2.java`)

#### 2.1 Interface and Method Signatures
- **Class**: `public class Program2`
- **Recommended Methods**:
  ```java
  public static int findMin(int[] numbers)
  public static int findMax(int[] numbers)
  public static int[] sortAscending(int[] numbers)
  public static int[] sortDescending(int[] numbers)
  public static void main(String[] args)
  ```

#### 2.2 Algorithmic Requirements (No Library Sorting)
- **Constraint**: Must NOT use `java.util.Arrays.sort` or any library utilities.
- **Sorting Algorithm**: In-place Bubble Sort or Selection Sort on an array clone.
  - **Ascending Bubble Sort**:
    ```java
    int[] sorted = numbers.clone();
    for (int i = 0; i < sorted.length - 1; i++) {
        for (int j = 0; j < sorted.length - 1 - i; j++) {
            if (sorted[j] > sorted[j + 1]) {
                int temp = sorted[j];
                sorted[j] = sorted[j + 1];
                sorted[j + 1] = temp;
            }
        }
    }
    ```
  - **Descending Order**:
    Can be obtained by either:
    1. Bubble sort with `<` comparator, OR
    2. Reading the ascending array in reverse from index 4 down to 0.

#### 2.3 Output Formatting
```
Enter 5 numbers:
42 17 88 5 23

Lowest number: 5
Highest number: 88
Ascending order: 5 17 23 42 88
Descending order: 88 42 23 17 5
```

---

### 3. Program 3: Number System Converter Using Arrays (`Program3.java`)

#### 3.1 Interface and Method Signatures
- **Class**: `public class Program3`
- **Recommended Methods**:
  ```java
  public static String convertToBase(int decimal, int base)
  public static void main(String[] args)
  ```

#### 3.2 Menu Specification
The program displays the following menu:
```
--- Number System Converter ---
1 - Decimal to Binary
2 - Decimal to Octal
3 - Decimal to Hexadecimal
Enter your choice (1-3): 
```
Followed by:
```
Enter a positive decimal number: 
```

#### 3.3 Array-Based Conversion Algorithm
- **Constraint**: Must NOT use `Integer.toBinaryString()`, `Integer.toOctalString()`, `Integer.toHexString()`.
- **Digit Array Implementation**:
  ```java
  public static String convertToBase(int decimal, int base) {
      if (decimal == 0) {
          return "0";
      }
      char[] hexSymbols = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
      char[] digits = new char[64];
      int count = 0;
      int temp = decimal;
      while (temp > 0) {
          int remainder = temp % base;
          digits[count++] = hexSymbols[remainder];
          temp = temp / base;
      }
      // Reverse array into result
      char[] result = new char[count];
      for (int i = 0; i < count; i++) {
          result[i] = digits[count - 1 - i];
      }
      return new String(result);
  }
  ```
- **Base mapping**:
  - Choice `1` $\rightarrow \text{base} = 2$
  - Choice `2` $\rightarrow \text{base} = 8$
  - Choice `3` $\rightarrow \text{base} = 16$
- **Zero & Negative Handling**:
  - If input is 0: Immediately store `'0'` in array and return `"0"`.
  - If input is negative: Display error "Error: Please enter a positive decimal value."

---

### 4. Program 4: Triangle Classification (`Program4.java`)

#### 4.1 Interface and Method Signatures
- **Class**: `public class Program4`
- **Recommended Methods**:
  ```java
  public static boolean isValidTriangle(double a, double b, double c)
  public static String classifyTriangle(double a, double b, double c)
  public static void main(String[] args)
  ```

#### 4.2 Triangle Inequality & Classification Logic
1. **Side Length Positivity**:
   $$a > 0 \land b > 0 \land c > 0$$
2. **Triangle Inequality Theorem**:
   $$a + b > c \land a + c > b \land b + c > a$$
   If any condition fails, the sides do not form a triangle.
3. **Classification**:
   - **Equilateral**:
     $$a == b \land b == c$$
   - **Isosceles**:
     $$(a == b \lor b == c \lor a == c)$$
     *(When checked after Equilateral, guarantees exactly two sides equal)*
   - **Scalene**:
     $$a \ne b \land b \ne c \land a \ne c$$

#### 4.3 Output Examples
```
Enter side 1: 5
Enter side 2: 5
Enter side 3: 5
The triangle is Equilateral.
```
```
Enter side 1: 1
Enter side 2: 2
Enter side 3: 3
The given sides do not form a valid triangle.
```

---

### 5. Program 5: Palindrome Number Checker (`Program5.java`)

#### 5.1 Interface and Method Signatures
- **Class**: `public class Program5`
- **Recommended Methods**:
  ```java
  public static boolean isPalindrome(long number)
  public static void main(String[] args)
  ```

#### 5.2 Arithmetic Digit Reversal Algorithm
- **Constraint**: Must NOT use `StringBuilder.reverse()` or external library tools.
- **Pure Arithmetic Method**:
  ```java
  public static boolean isPalindrome(long number) {
      if (number < 0) {
          return false; // Negative numbers have a '-' sign and are not palindromes
      }
      long original = number;
      long reversed = 0;
      long temp = number;
      while (temp > 0) {
          long digit = temp % 10;
          reversed = reversed * 10 + digit;
          temp /= 10;
      }
      return original == reversed;
  }
  ```
- **Alternative / Supplementary Array Method**:
  Extract digits into an `int[]` array using `% 10` and `/ 10`, then compare pointers from start (`0`) and end (`count - 1`).
- **Edge Conditions**:
  - `0`: Palindrome (`0 == 0`).
  - Single digits `1-9`: Palindromes.
  - Numbers ending in 0 (e.g. `10`, `1200`): Non-palindromes.
  - Negative numbers (`-121`): Not palindromes due to sign asymmetry.

---

## Architectural & CpE 02 Guidelines Compliance Checklist
- [x] All 5 programs use standard Java SE (`Scanner`, standard arrays).
- [x] No pre-built algorithmic library shortcuts used.
- [x] Proper control structures with `{}` block brackets.
- [x] Separate standalone `.java` files with dedicated `main` methods.
- [x] Dual-purpose design: console interactive + directly testable static methods.
