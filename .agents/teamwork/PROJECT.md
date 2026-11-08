# Project: CpE 02 Programming Logic and Design Standalone Java Suite

## Architecture
The system consists of 10 standalone Java console applications (`Program1.java` through `Program10.java`) adhering to the Programming Logic and Design (CpE 02) curriculum.
- Package: Default package (standalone executable classes).
- Runtime target: Java SE 17 / 21.
- Core constraint: NO external libraries or third-party frameworks for core functionality. Only standard Java SE (`Scanner`, basic arrays, standard primitive types).
- Structure: Each program contains its own `public static void main(String[] args)` method with standard control structures (decision `if/else`, repetition `for/while/do-while`, branching `break/continue/return`).
- Testing Track: Comprehensive opaque-box test runner (`test_runner.ps1`) executing all 10 programs via interactive process redirection (stdin/stdout) with strict timeouts and exit code checks.

## Feature Inventory
Every feature identified during Phase 0 Survey is cataloged below with its designated milestone.

| # | Feature | Description | Milestone | Source |
|---|---------|-------------|-----------|--------|
| 1 | JDK Toolchain & Target Directory | Provision Java JDK (javac, java) and create `cpe02_java_programs` directory | M0 | Survey (Explorer 3) |
| 2 | F1: Arithmetic Sequence | `createArithmeticSeq` function, 16-element array, prompt for `first` and `diff`, space-separated output, `main` entry point | M1 | ORIGINAL_REQUEST §R1 |
| 3 | F2: Min/Max & 5-Number Sorting | Input 5 numbers, find min/max, sort ascending and descending using manual loop-based algorithm (Bubble/Selection) without `Arrays.sort()` | M1 | ORIGINAL_REQUEST §R2 |
| 4 | F3: Number System Converter | Decimal input, menu choices (1: Binary, 2: Octal, 3: Hexadecimal), array-based digit conversion with reverse output, zero handling | M1 | ORIGINAL_REQUEST §R3 |
| 5 | F4: Triangle Classification | 3 side inputs, triangle inequality validation ($a+b>c \land a+c>b \land b+c>a$), classify equilateral, isosceles, scalene | M1 | ORIGINAL_REQUEST §R4 |
| 6 | F5: Palindrome Number Checker | Number input, reverse integer digits using arithmetic (%10, /10), test equality, negative handling | M1 | ORIGINAL_REQUEST §R5 |
| 7 | F6: Day of Year Calculation | Inputs month, day, year; Gregorian leap year rule `(y%4==0 && y%100!=0) || y%400==0`; array of month days; output day number 1-366 | M2 | ORIGINAL_REQUEST §R6 |
| 8 | F7: Prime or Composite Checker | Integer input, handles <= 1 (neither), 2 is prime, evens > 2 composite, $O(\sqrt{n})$ trial division without `Math.sqrt()` overflow | M2 | ORIGINAL_REQUEST §R7 |
| 9 | F8: Greatest Common Divisor | 2 integer inputs, Euclidean modulo algorithm, handles negatives via absolute value, handles zero inputs, outputs GCD | M2 | ORIGINAL_REQUEST §R8 |
| 10 | F9: Daily Temperatures Analysis | Dynamic input loop, classify each temp: Hot (>=85), Pleasant (60-84), Cold (<60), print category per temp and count totals | M2 | ORIGINAL_REQUEST §R9 |
| 11 | F10: Exam Scores & Grade Distribution | Input scores (0-100) until negative sentinel (e.g. -1), tally grade counts (A: 90-100, B: 80-89, C: 70-79, D: 60-69, F: 0-59) and total grades | M2 | ORIGINAL_REQUEST §R10 |
| 12 | F11: CpE 02 Control Structures & Formatting | Standard block brackets `{ }`, consistent indentation, `==` comparisons, zero external dependencies | M1, M2 | ORIGINAL_REQUEST §R11 |
| 13 | F12: Automated Test Harness (Tiers 1-4) | PowerShell test runner (`test_runner.ps1`) validating all 10 programs across feature, boundary, and scenario test tiers | E2E | ORIGINAL_REQUEST §Acceptance |
| 14 | F13: Adversarial Verification & Hardening | Adversarial edge case stress testing, zero-tolerance integrity audit, clean execution verification | M3 | System Integrity Policy |

## Milestones
| # | Name | Scope | Dependencies | Status |
|---|------|-------|-------------|--------|
| M0 | Toolchain & Directory Setup | Provision JDK 21 / javac / java in user environment, create directory `cpe02_java_programs` | None | DONE |
| M1 | Programs 1–5 Implementation | Implement `Program1.java` through `Program5.java` adhering to CpE 02 conventions | M0 | DONE |
| M2 | Programs 6–10 Implementation | Implement `Program6.java` through `Program10.java` adhering to CpE 02 conventions | M0 | DONE |
| E2E | E2E Test Suite & Harness | Design and create `test_runner.ps1`, comprehensive test fixtures (Tiers 1-4), publish `TEST_READY.md` | M0 | DONE |
| M3 | Final E2E Pass & Adversarial Hardening | Execute 100% of E2E tests, run Challenger edge cases, Forensic Integrity Audit, and final signoff | M1, M2, E2E | DONE |

## Interface Contracts

### Program 1: Arithmetic Sequence (`Program1.java`)
- Prompt: Prompts user for `first` term and common difference `diff`.
- Function: `public static int[] createArithmeticSeq(int first, int diff)` or interactive helper `public static void createArithmeticSeq(Scanner scanner)`.
- Array: `int[16]` where `arr[i] = first + i * diff`.
- Output: Space-separated terms on a line: `21 26 31 36 41 46 51 56 61 66 71 76 81 86 91 96`.

### Program 2: Min/Max and Sorting (`Program2.java`)
- Input: 5 integer values from user via `Scanner`.
- Logic: Compute minimum and maximum directly; sort ascending and descending using manual loop-based algorithm (Selection or Bubble sort, NO `Arrays.sort()`).
- Output:
  - Minimum number and Maximum number.
  - Numbers in ascending order (space-separated).
  - Numbers in descending order (space-separated).

### Program 3: Number System Converter (`Program3.java`)
- Input: Positive decimal integer, then menu selection (1: Binary, 2: Octal, 3: Hexadecimal).
- Logic:
  - Base 2: successive `% 2` and `/ 2`, store bits in `int[]` or `char[]`, output in reverse.
  - Base 8: successive `% 8` and `/ 8`, store digits in array, output in reverse.
  - Base 16: successive `% 16` and `/ 16`, map remainder 0-9 to '0'-'9' and 10-15 to 'A'-'F' in `char[]`, output in reverse.
- Edge case: Input `0` outputs `"0"`.

### Program 4: Triangle Classification (`Program4.java`)
- Input: 3 positive numbers (sides $a, b, c$).
- Validity check: $a + b > c \land a + c > b \land b + c > a$. If invalid, print invalid triangle.
- Classification:
  - If $a == b \land b == c$ -> "Equilateral"
  - Else if $a == b \lor b == c \lor a == c$ -> "Isosceles"
  - Else -> "Scalene"

### Program 5: Palindrome Number Checker (`Program5.java`)
- Input: Integer $N$.
- Logic: If $N < 0$, not a palindrome. For $N \ge 0$, extract reversed integer via loop: `rev = rev * 10 + (temp % 10); temp /= 10;`. Check if `rev == N`.
- Output: Explicit declaration whether the number is a palindrome or not.

### Program 6: Day of Year Calculation (`Program6.java`)
- Input: Three integers: `month` (1-12), `day` (1-31), `year`.
- Leap year rule: `(year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)`.
- Array: `int[] daysInMonth = {31, isLeap ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}`.
- Accumulate days of prior months plus `day`. Output day number (1 to 366).

### Program 7: Prime or Composite Checker (`Program7.java`)
- Input: Integer $N$.
- Logic:
  - If $N \le 1$: Neither prime nor composite.
  - If $N == 2$: Prime.
  - If $N % 2 == 0$: Composite.
  - Loop $d = 3$ to $d \le N / d$ with $d += 2$: if $N % d == 0$, Composite.
  - Otherwise: Prime.

### Program 8: Greatest Common Divisor (`Program8.java`)
- Input: 2 integers $a$ and $b$.
- Logic: Normalize to non-negative: `a = Math.abs(a); b = Math.abs(b);`. While `b != 0`, `t = b; b = a % b; a = t;`. Return `a`.
- Output: GCD value.

### Program 9: Daily High Temperatures Analysis (`Program9.java`)
- Input: Dynamic stream of integers (loop `while (scanner.hasNextInt())` or interactive input until sentinel like `-999`).
- Categorization:
  - High temperature $\ge 85$: Hot
  - $60 \le \text{temperature} \le 84$: Pleasant
  - Temperature $< 60$: Cold
- Output: Each temperature printed with its category, followed by summary counts for Hot days, Pleasant days, and Cold days.

### Program 10: Exam Scores and Grade Distribution (`Program10.java`)
- Input: Sequence of exam scores (0-100) until a negative integer (e.g., `-1`) is entered.
- Buckets:
  - 90 to 100: A
  - 80 to 89: B
  - 70 to 79: C
  - 60 to 69: D
  - 0 to 59: F
- Output: Total number of valid grades and count for each letter grade category.

## Code Layout
```
c:\Users\felix\Documents\Violeta Programing projects\
├── cpe02_java_programs/
│   ├── Program1.java
│   ├── Program2.java
│   ├── Program3.java
│   ├── Program4.java
│   ├── Program5.java
│   ├── Program6.java
│   ├── Program7.java
│   ├── Program8.java
│   ├── Program9.java
│   ├── Program10.java
│   └── test_runner.ps1
└── .agents/
    └── teamwork/
        ├── ORIGINAL_REQUEST.md
        ├── PROJECT.md
        ├── TEST_INFRA.md
        ├── TEST_READY.md
        └── orchestrator/
            ├── BRIEFING.md
            ├── DISPATCH.md
            ├── progress.md
            └── GATE_STATUS.md
```
