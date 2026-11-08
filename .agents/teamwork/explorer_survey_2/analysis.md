# Comprehensive Specification Analysis: Programs 6 through 10

## Executive Summary & Objective

This specification document provides an exhaustive, authoritative analysis of **Programs 6 through 10** for the **CpE 02 (Programming Logic and Design)** course suite, as mandated in `ORIGINAL_REQUEST.md` (Requirements R6, R7, R8, R9, R10, and general constraints R11).

The objective is to establish unambiguous behavioral contracts, input/output schemas, algorithmic logic, boundary conditions, edge cases, and architectural constraints for:
- **Program 6 (`Program6.java`)**: Day of the Year Calculation.
- **Program 7 (`Program7.java`)**: Prime or Composite Number Checker.
- **Program 8 (`Program8.java`)**: Greatest Common Divisor (GCD) Calculator.
- **Program 9 (`Program9.java`)**: Daily High Temperatures Dynamic Categorization and Frequency Analysis.
- **Program 10 (`Program10.java`)**: Exam Scores and Grade Distribution Analysis with Sentinel Control.
- **R11 Conventions**: Standard Java SE control structures, block indentation, scanner input handling, and strict prohibition of prebuilt libraries for core functionality.

---

## Detailed Requirement & Architectural Analysis

### 1. Program 6: Day of Year Calculation (`Program6.java`)

#### 1.1 Specification & Purpose
Accepts three integer inputs representing a date (`month`, `day`, `year`) from standard input and determines the sequential day number ($1$ to $366$) within that calendar year.

#### 1.2 Mathematical Formulation & Leap Year Rules
The Gregorian calendar leap year rule is defined mathematically as:
$$\text{isLeapYear}(Y) = ((Y \pmod 4 == 0) \land (Y \pmod{100} \neq 0)) \lor (Y \pmod{400} == 0)$$

- **Rule 1**: Any year evenly divisible by 4 is a leap year.
- **Rule 2**: Except if divisible by 100, it is NOT a leap year...
- **Rule 3**: ...Unless it is also divisible by 400, in which case it IS a leap year.

**Century Year Demonstrations**:
- $1600$: Divisible by 400 $\rightarrow$ Leap Year ($366$ days).
- $1900$: Divisible by 100, not 400 $\rightarrow$ Non-Leap Year ($365$ days).
- $2000$: Divisible by 400 $\rightarrow$ Leap Year ($366$ days).
- $2100$: Divisible by 100, not 400 $\rightarrow$ Non-Leap Year ($365$ days).

#### 1.3 Days Per Month Array & Day of Year Calculation
A 12-element integer array stores standard days per month (January through December):
```java
int[] daysInMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
```
If `isLeapYear(year)` is true, February (`daysInMonth[1]`) is dynamically adjusted to `29`.

The sequential day number is calculated by summing the days of all preceding months plus the current day:
$$\text{dayOfYear} = \left(\sum_{m=0}^{\text{month}-2} \text{daysInMonth}[m]\right) + \text{day}$$

#### 1.4 Critical Analysis of Prompt Phrasing & Mathematical Fact
In `ORIGINAL_REQUEST.md` line 66:
> *"day 60 for Mar 1 2000 (leap year) vs Mar 1 1900 (non-leap year)"*

**Rigorous Mathematical Verification**:
- **Non-Leap Year (e.g., 1900)**:
  - January: 31 days (Days 1 to 31)
  - February: 28 days (Days 32 to 59)
  - **March 1**: $31 + 28 + 1 = \mathbf{60}$.
- **Leap Year (e.g., 2000)**:
  - January: 31 days (Days 1 to 31)
  - February: 29 days (Days 32 to 60) $\rightarrow$ **February 29 is Day 60**.
  - **March 1**: $31 + 29 + 1 = \mathbf{61}$.

**Conclusion**: The author of the prompt contrasted March 1 in 2000 vs 1900, but inverted the numbers in the sentence structure (March 1 in 1900 is Day 60, whereas March 1 in 2000 is Day 61; or alternately, Day 60 is February 29 in 2000 vs March 1 in 1900). Implementations must compute the mathematically exact calendar values:
- `Jan 1 1994` $\rightarrow$ Day $1$
- `Dec 31 1993` $\rightarrow$ Day $365$
- `Dec 31 1996` $\rightarrow$ Day $366$
- `Feb 29 2000` $\rightarrow$ Day $60$
- `Mar 1 1900` $\rightarrow$ Day $60$
- `Mar 1 2000` $\rightarrow$ Day $61$

---

### 2. Program 7: Prime or Composite Checker (`Program7.java`)

#### 2.1 Specification & Purpose
Accepts an integer $n$ from the user and determines whether $n$ is a **prime number**, a **composite number**, or **neither**.

#### 2.2 Definitions
1. **Prime Number**: An integer $n > 1$ that has exactly two distinct positive divisors: $1$ and $n$. (e.g., $2, 3, 5, 7, 11, 13, 17, \dots$).
2. **Composite Number**: An integer $n > 1$ that has more than two positive divisors (i.e., at least one divisor $d$ such that $1 < d < n$). (e.g., $4, 6, 8, 9, 10, 12, 14, 15, \dots$).
3. **Special Cases**:
   - $n = 1$: Only has one positive divisor ($1$). It is neither prime nor composite by definition.
   - $n = 0$: Infinitely divisible; neither prime nor composite.
   - $n < 0$: By standard elementary arithmetic conventions, prime and composite definitions apply exclusively to positive integers $> 1$. Negative numbers are neither prime nor composite.

#### 2.3 Optimal Algorithm ($O(\sqrt{n})$ Trial Division)
To satisfy R11 without using prebuilt math libraries:
1. If $n \le 1$: Output that $n$ is neither prime nor composite.
2. If $n == 2$: Output that $2$ is prime (the only even prime).
3. If $n > 2$ and $n \pmod 2 == 0$: Output that $n$ is composite.
4. For odd divisors $d = 3, 5, 7, \dots$ while $d \le n / d$ (to prevent 32-bit integer multiplication overflow):
   - If $n \pmod d == 0$: $n$ is composite; terminate early using `break`.
5. If loop completes without finding any divisor: $n$ is prime.

---

### 3. Program 8: Greatest Common Divisor (`Program8.java`)

#### 3.1 Specification & Purpose
Accepts 2 integers $a$ and $b$ from the user and outputs their Greatest Common Divisor ($\gcd(a, b)$).

#### 3.2 Mathematical Formulation & Properties
- $\gcd(a, b)$ is defined as the largest positive integer that divides both $a$ and $b$.
- **Signs**: $\gcd(a, b) = \gcd(|a|, |b|)$. The result is always non-negative.
- **Zeros**:
  - If $a \neq 0$ and $b = 0$: $\gcd(a, 0) = |a|$.
  - If $a = 0$ and $b \neq 0$: $\gcd(0, b) = |b|$.
  - If $a = 0$ and $b = 0$: $\gcd(0, 0)$ is mathematically undefined (standard software returns $0$ or prompts an error).
- **Coprimes**: If $a$ and $b$ share no prime factors other than $1$, $\gcd(a, b) = 1$ (e.g., $17$ and $19$).

#### 3.3 Algorithm (Euclidean Modulo Loop)
Using pure standard control structures (`while` loop, modulo `%`):
```java
int n1 = (a < 0) ? -a : a;
int n2 = (b < 0) ? -b : b;

while (n2 != 0) {
    int temp = n2;
    n2 = n1 % n2;
    n1 = temp;
}
int gcd = n1;
```
- Automatically handles $a < b$ on the first iteration by swapping them via modulo.
- Executes in logarithmic time $O(\log(\min(a, b)))$.

---

### 4. Program 9: Daily High Temperatures Analysis (`Program9.java`)

#### 4.1 Specification & Purpose
Dynamically reads daily high temperature readings from standard input, classifies each reading into one of three categories, displays the category of each reading, and prints summary frequency totals.

#### 4.2 Categorization Rules
- **Hot**: Temperature $\ge 85$
- **Pleasant**: Temperature $60 \le T \le 84$ (inclusive)
- **Cold**: Temperature $< 60$

#### 4.3 Input Loop Design (Dynamic Stream & Sentinel Compatibility)
Because `ORIGINAL_REQUEST.md` specifies reading "dynamically from standard input", and both interactive and automated CLI pipeline execution must be supported:
- Loop structure:
  ```java
  while (scanner.hasNextInt()) {
      int temp = scanner.nextInt();
      if (temp == -99) { // standard sentinel support if supplied
          break;
      }
      // Process temp
  }
  ```
  Supporting both stream termination (`!scanner.hasNextInt()`) and sentinel value (e.g. `-99`) ensures full compliance with piped test vectors and interactive console entry.

#### 4.4 In-Depth Analysis of the 25 Sample Temperatures
The prompt provides this specific sample dataset:
`55, 62, 68, 74, 59, 45, 41, 58, 60, 67, 65, 78, 82, 88, 91, 92, 90, 93, 87, 78, 79, 72, 68, 61, 59`

Let us trace each number against the stated rules:
1. $55 \rightarrow < 60 \rightarrow$ **Cold**
2. $62 \rightarrow 60 \dots 84 \rightarrow$ **Pleasant**
3. $68 \rightarrow 60 \dots 84 \rightarrow$ **Pleasant**
4. $74 \rightarrow 60 \dots 84 \rightarrow$ **Pleasant**
5. $59 \rightarrow < 60 \rightarrow$ **Cold**
6. $45 \rightarrow < 60 \rightarrow$ **Cold**
7. $41 \rightarrow < 60 \rightarrow$ **Cold**
8. $58 \rightarrow < 60 \rightarrow$ **Cold**
9. $60 \rightarrow 60 \dots 84 \rightarrow$ **Pleasant** (boundary $60$)
10. $67 \rightarrow 60 \dots 84 \rightarrow$ **Pleasant**
11. $65 \rightarrow 60 \dots 84 \rightarrow$ **Pleasant**
12. $78 \rightarrow 60 \dots 84 \rightarrow$ **Pleasant**
13. $82 \rightarrow 60 \dots 84 \rightarrow$ **Pleasant**
14. $88 \rightarrow \ge 85 \rightarrow$ **Hot**
15. $91 \rightarrow \ge 85 \rightarrow$ **Hot**
16. $92 \rightarrow \ge 85 \rightarrow$ **Hot**
17. $90 \rightarrow \ge 85 \rightarrow$ **Hot**
18. $93 \rightarrow \ge 85 \rightarrow$ **Hot**
19. $87 \rightarrow \ge 85 \rightarrow$ **Hot**
20. $78 \rightarrow 60 \dots 84 \rightarrow$ **Pleasant**
21. $79 \rightarrow 60 \dots 84 \rightarrow$ **Pleasant**
22. $72 \rightarrow 60 \dots 84 \rightarrow$ **Pleasant**
23. $68 \rightarrow 60 \dots 84 \rightarrow$ **Pleasant**
24. $61 \rightarrow 60 \dots 84 \rightarrow$ **Pleasant**
25. $59 \rightarrow < 60 \rightarrow$ **Cold**

**Category Counts by Rule**:
- **Hot ($\ge 85$)**: $\{88, 91, 92, 90, 93, 87\}$ $\rightarrow$ **6 days**
- **Pleasant ($60 \dots 84$)**: $\{62, 68, 74, 60, 67, 65, 78, 82, 78, 79, 72, 68, 61\}$ $\rightarrow$ **13 days**
- **Cold ($< 60$)**: $\{55, 59, 45, 41, 58, 59\}$ $\rightarrow$ **6 days**
- **Total**: $6 + 13 + 6 = \mathbf{25}$ days.

**Discrepancy Resolution**:
The prompt notes in parentheses: `-> 7 hot, 11 pleasant, 7 cold`.
- If Hot were $\ge 82$, $\{82, 88, 91, 92, 90, 93, 87\}$ = 7.
- If Cold were $\le 60$, $\{55, 59, 45, 41, 58, 60, 59\}$ = 7.
- If Pleasant were $61 \dots 81$, 11 days.
However, the prompt's explicit text defines:
`hot days (high temperature >= 85), pleasant days (60 to 84), and cold days (< 60)`.
Therefore, the program **must** strictly apply the explicit range thresholds:
- `temp >= 85` $\rightarrow$ Hot
- `temp >= 60 && temp <= 84` $\rightarrow$ Pleasant
- `temp < 60` $\rightarrow$ Cold

---

### 5. Program 10: Exam Scores and Grade Distribution (`Program10.java`)

#### 5.1 Specification & Purpose
Reads integer exam scores ($0 \dots 100$) until a negative sentinel value (e.g., `-1`) is entered. Excludes the negative sentinel from calculations, and outputs:
1. Total number of grades processed.
2. Frequency count of grades in each bucket:
   - **A**: $90$ to $100$
   - **B**: $80$ to $89$
   - **C**: $70$ to $79$
   - **D**: $60$ to $69$
   - **F**: $0$ to $59$

#### 5.2 Sentinel Handling
- The termination condition is strictly any negative integer: `score < 0` (or `score == -1`).
- The negative score is intercepted prior to tallying and discarded immediately (`break`).

#### 5.3 Verification Test Case Trace
Input: `98 87 86 85 85 78 73 72 72 72 70 66 63 50 -1`
- 98: A (A=1)
- 87, 86, 85, 85: B (B=4)
- 78, 73, 72, 72, 72, 70: C (C=6)
- 66, 63: D (D=2)
- 50: F (F=1)
- -1: Sentinel (loop terminates)

**Verification**:
- Total = $14$
- A = $1$, B = $4$, C = $6$, D = $2$, F = $1$.
- Total matches sum of category counts ($1 + 4 + 6 + 2 + 1 = 14$). Exactly matches acceptance criteria!

---

### 6. R11 Programming Logic & Control Structure Conventions

All five programs must strictly follow these structural and pedagogical guidelines:
1. **Control Structures**:
   - Sequence: Linear statement execution.
   - Selection: `if`, `if-else`, `if-else if-else`, `switch`.
   - Repetition: `while`, `do-while`, `for`.
   - Branching: `break`, `return`.
2. **Braces and Indentation**: Every block must use standard `{ }` curly brackets with clean, consistent 4-space indentation.
3. **Array Usage**: Standard 1D Java arrays (e.g., `int[] daysInMonth`, `int[] gradeCounts`) must be utilized where required.
4. **No Forbidden Libraries**: Core algorithms must be implemented from first principles.
   - NO `java.time.LocalDate` or `Calendar` for Program 6.
   - NO `BigInteger.isProbablePrime()` or `BigInteger.gcd()` for Programs 7 and 8.
   - NO `java.util.stream.IntStream` or external collections frameworks for Programs 9 and 10.
5. **Standard Input**: `java.util.Scanner` bound to `System.in`.

---

## Features Discovered

| # | Category | Feature | Description | Inputs | Outputs | Error Behavior | Discovered Via |
|---|----------|---------|-------------|--------|---------|----------------|----------------|
| 1 | Program 6 | Date Input Reading | Prompts and reads month, day, year as integers via `Scanner` | `int month, day, year` | Prompts to stdout | InputMismatchException if non-int | `ORIGINAL_REQUEST.md` R6 |
| 2 | Program 6 | Leap Year Check | Evaluates `(Y%4==0 && Y%100!=0) \|\| (Y%400==0)` | `int year` | `boolean isLeap` | False for non-leap century years (1900, 2100) | `ORIGINAL_REQUEST.md` R6 |
| 3 | Program 6 | Month Days Lookup Array | Array of month lengths `[31, 28/29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]` | `int month` (1-12) | Days in month ($28 \dots 31$) | IndexOutOfBoundsException if unvalidated | `ORIGINAL_REQUEST.md` R6, R11 |
| 4 | Program 6 | Leap Day Adjustment | Updates February to 29 days if leap year | `boolean isLeap` | Feb = 29 | Reverts to 28 for non-leap | `ORIGINAL_REQUEST.md` R6 |
| 5 | Program 6 | Day of Year Summation | Iteratively sums preceding months' days plus current day | `month, day, daysInMonth[]` | `int dayOfYear` ($1 \dots 366$) | Returns calculated total | `ORIGINAL_REQUEST.md` R6 |
| 6 | Program 6 | Date Validation | Checks valid month ($1 \dots 12$) and valid day ($1 \dots \text{maxDays}$) | `month, day, year` | Error message or day number | Rejects invalid dates | Probed edge case |
| 7 | Program 7 | Single Integer Input | Reads integer $n$ to test for primality | `int n` | Prompt to stdout | InputMismatchException if non-int | `ORIGINAL_REQUEST.md` R7 |
| 8 | Program 7 | Non-Positive / 0 Handling | Identifies numbers $\le 0$ as neither prime nor composite | `int n <= 0` | "neither prime nor composite" | Handled via early check | Probed edge case |
| 9 | Program 7 | Unit (1) Handling | Identifies 1 as neither prime nor composite | `int n == 1` | "neither prime nor composite" | Handled via early check | Probed edge case |
| 10 | Program 7 | Even Number Check | Identifies 2 as prime, and even numbers $> 2$ as composite | `int n % 2 == 0` | "prime" for 2, "composite" for even $>2$ | Early exit branching | `ORIGINAL_REQUEST.md` R7 |
| 11 | Program 7 | $O(\sqrt{n})$ Trial Division | Tests odd divisors $3, 5, 7 \dots$ while $d \le n/d$ | `int n` | Divisor found or not | Prevents overflow without `Math.sqrt` | `ORIGINAL_REQUEST.md` R7 |
| 12 | Program 7 | Result Display | Formats prime/composite message clearly | `int n, boolean isPrime` | Descriptive message to stdout | Clean stdout output | `ORIGINAL_REQUEST.md` R7 |
| 13 | Program 8 | Two Integers Input | Prompts and reads two integers $a$ and $b$ | `int a, int b` | Prompts to stdout | InputMismatchException if non-int | `ORIGINAL_REQUEST.md` R8 |
| 14 | Program 8 | Negative Input Handling | Normalizes inputs to absolute values: $|a|$ and $|b|$ | `int a, int b` | Non-negative integers | Handled via `if (a < 0) a = -a` | Probed edge case |
| 15 | Program 8 | Zero Operand Handling | Returns $|a|$ if $b=0$, returns $|b|$ if $a=0$ | `a=0` or `b=0` | Non-zero operand or 0 | Output 0/undefined if both 0 | Probed edge case |
| 16 | Program 8 | Euclidean Modulo Loop | Calculates GCD via `temp = b; b = a % b; a = temp;` | `int a, int b` | `int gcd` | Terminates when $b == 0$ | `ORIGINAL_REQUEST.md` R8 |
| 17 | Program 8 | Coprime Determination | Accurately yields GCD = 1 for relative primes | `e.g. 17, 19` | "GCD is 1" | Handled uniformly | `ORIGINAL_REQUEST.md` R8 |
| 18 | Program 8 | GCD Display | Outputs clear message with both input values and GCD | `a, b, gcd` | Formatted stdout message | Clean stdout output | `ORIGINAL_REQUEST.md` R8 |
| 19 | Program 9 | Dynamic Input Loop | Reads stream of temperatures until EOF or sentinel (`-99`) | Dynamic stream | Category output per item | Exits gracefully on stream close | `ORIGINAL_REQUEST.md` R9 |
| 20 | Program 9 | Hot Classification | Identifies days with temperature $\ge 85$ as "Hot" | `int temp >= 85` | Print "Hot", `hotCount++` | Precise boundary check | `ORIGINAL_REQUEST.md` R9 |
| 21 | Program 9 | Pleasant Classification | Identifies days with $60 \le temp \le 84$ as "Pleasant" | `60 <= temp <= 84` | Print "Pleasant", `pleasantCount++` | Precise range check | `ORIGINAL_REQUEST.md` R9 |
| 22 | Program 9 | Cold Classification | Identifies days with $temp < 60$ as "Cold" | `int temp < 60` | Print "Cold", `coldCount++` | Precise upper bound check | `ORIGINAL_REQUEST.md` R9 |
| 23 | Program 9 | Per-Item Output | Prints the category corresponding to each entered temperature | `int temp` | e.g. "Temperature X is [Hot/Pleasant/Cold]" | Displayed immediately or sequentially | `ORIGINAL_REQUEST.md` R9 |
| 24 | Program 9 | Summary Report | Prints total count of hot days, pleasant days, cold days | Counters | Total counts to stdout | Matches dataset rules | `ORIGINAL_REQUEST.md` R9 |
| 25 | Program 10 | Sentinel-Controlled Input | Reads scores until negative number (e.g., `-1`) is entered | Sequence of ints | Processing loop | Terminates on `score < 0` | `ORIGINAL_REQUEST.md` R10 |
| 26 | Program 10 | Sentinel Exclusion | Excludes sentinel from total score count and letter buckets | Sentinel (e.g. `-1`) | Immediate `break` | Never counted in totals | `ORIGINAL_REQUEST.md` R10 |
| 27 | Program 10 | Grade A Bucket | Tally for scores $90 \dots 100$ | `90 <= score <= 100` | `countA++` | Validated range | `ORIGINAL_REQUEST.md` R10 |
| 28 | Program 10 | Grade B Bucket | Tally for scores $80 \dots 89$ | `80 <= score <= 89` | `countB++` | Validated range | `ORIGINAL_REQUEST.md` R10 |
| 29 | Program 10 | Grade C Bucket | Tally for scores $70 \dots 79$ | `70 <= score <= 79` | `countC++` | Validated range | `ORIGINAL_REQUEST.md` R10 |
| 30 | Program 10 | Grade D Bucket | Tally for scores $60 \dots 69$ | `60 <= score <= 69` | `countD++` | Validated range | `ORIGINAL_REQUEST.md` R10 |
| 31 | Program 10 | Grade F Bucket | Tally for scores $0 \dots 59$ | `0 <= score <= 59` | `countF++` | Validated range | `ORIGINAL_REQUEST.md` R10 |
| 32 | Program 10 | Distribution Summary | Outputs total grades processed and breakdown for A, B, C, D, F | Array or counters | Summary table / lines to stdout | Total equals sum of buckets | `ORIGINAL_REQUEST.md` R10 |
| 33 | R11 All | Pure Java SE Logic | Core logic uses only primitive operators and control flow | Standard types | Deterministic output | No external library dependencies | `ORIGINAL_REQUEST.md` R11 |

---

## Edge Cases

| # | Feature | Input | Observed / Expected Behavior |
|---|---------|-------|-------------------------------|
| 1 | Program 6 (Day of Year) | Month: `1`, Day: `1`, Year: `1994` | Output: Day `1` (first day of non-leap year). |
| 2 | Program 6 (Day of Year) | Month: `12`, Day: `31`, Year: `1993` | Output: Day `365` (last day of non-leap year). |
| 3 | Program 6 (Day of Year) | Month: `12`, Day: `31`, Year: `1996` | Output: Day `366` (last day of leap year: $1996$ divisible by 4). |
| 4 | Program 6 (Day of Year) | Month: `2`, Day: `28`, Year: `1900` | Output: Day `59` ($1900$ is non-leap century year: $1900 \pmod{100} == 0, 1900 \pmod{400} \neq 0$). |
| 5 | Program 6 (Day of Year) | Month: `3`, Day: `1`, Year: `1900` | Output: Day `60` ($31 + 28 + 1 = 60$). |
| 6 | Program 6 (Day of Year) | Month: `2`, Day: `29`, Year: `2000` | Output: Day `60` ($2000$ is leap century year: $2000 \pmod{400} == 0$). |
| 7 | Program 6 (Day of Year) | Month: `3`, Day: `1`, Year: `2000` | Output: Day `61` ($31 + 29 + 1 = 61$). |
| 8 | Program 6 (Day of Year) | Month: `2`, Day: `29`, Year: `1993` | Invalid date (non-leap year February has only 28 days). |
| 9 | Program 6 (Day of Year) | Month: `13`, Day: `1`, Year: `2024` | Invalid month (month must be between 1 and 12). |
| 10 | Program 6 (Day of Year) | Month: `4`, Day: `31`, Year: `2024` | Invalid day (April only has 30 days). |
| 11 | Program 7 (Prime/Composite) | Input: `2` | Output: `2 is a prime number.` (Smallest prime, only even prime). |
| 12 | Program 7 (Prime/Composite) | Input: `3` | Output: `3 is a prime number.` (Smallest odd prime). |
| 13 | Program 7 (Prime/Composite) | Input: `4` | Output: `4 is a composite number.` (Smallest composite number). |
| 14 | Program 7 (Prime/Composite) | Input: `1` | Output: `1 is neither prime nor composite.` |
| 15 | Program 7 (Prime/Composite) | Input: `0` | Output: `0 is neither prime nor composite.` |
| 16 | Program 7 (Prime/Composite) | Input: `-7` | Output: `-7 is neither prime nor composite.` |
| 17 | Program 7 (Prime/Composite) | Input: `9` | Output: `9 is a composite number.` (Smallest odd composite, $3 \times 3$). |
| 18 | Program 7 (Prime/Composite) | Input: `13` | Output: `13 is a prime number.` |
| 19 | Program 7 (Prime/Composite) | Input: `15` | Output: `15 is a composite number.` ($3 \times 5$). |
| 20 | Program 7 (Prime/Composite) | Input: `2147483647` | Output: `2147483647 is a prime number.` ($2^{31}-1$, 8th Mersenne prime; tests loop termination and overflow prevention). |
| 21 | Program 8 (GCD) | Inputs: `54`, `24` | Output: `GCD is 6`. ($54 = 6 \times 9, 24 = 6 \times 4$). |
| 22 | Program 8 (GCD) | Inputs: `24`, `54` | Output: `GCD is 6` (order-independent; first modulo swaps order). |
| 23 | Program 8 (GCD) | Inputs: `17`, `19` | Output: `GCD is 1` (both are distinct prime numbers; coprime). |
| 24 | Program 8 (GCD) | Inputs: `0`, `25` | Output: `GCD is 25` ($\gcd(0, b) = |b|$). |
| 25 | Program 8 (GCD) | Inputs: `30`, `0` | Output: `GCD is 30` ($\gcd(a, 0) = |a|$). |
| 26 | Program 8 (GCD) | Inputs: `0`, `0` | Output: `GCD is 0` or undefined. |
| 27 | Program 8 (GCD) | Inputs: `-54`, `24` | Output: `GCD is 6` (absolute value normalization). |
| 28 | Program 8 (GCD) | Inputs: `54`, `-24` | Output: `GCD is 6` (absolute value normalization). |
| 29 | Program 8 (GCD) | Inputs: `-54`, `-24` | Output: `GCD is 6` (both negative). |
| 30 | Program 8 (GCD) | Inputs: `42`, `42` | Output: `GCD is 42` (identical inputs). |
| 31 | Program 9 (Temperatures) | Inputs: 25 numbers (`55, 62, 68, 74, 59, 45, 41, 58, 60, 67, 65, 78, 82, 88, 91, 92, 90, 93, 87, 78, 79, 72, 68, 61, 59`) | Evaluated by rules: Hot = `6`, Pleasant = `13`, Cold = `6`. Total = `25`. Per-reading categories displayed for all 25 values. |
| 32 | Program 9 (Temperatures) | Input: `85` | Output: `Hot` (exact lower boundary of Hot $\ge 85$). |
| 33 | Program 9 (Temperatures) | Input: `84` | Output: `Pleasant` (exact upper boundary of Pleasant $60 \dots 84$). |
| 34 | Program 9 (Temperatures) | Input: `60` | Output: `Pleasant` (exact lower boundary of Pleasant $60 \dots 84$). |
| 35 | Program 9 (Temperatures) | Input: `59` | Output: `Cold` (exact upper boundary of Cold $< 60$). |
| 36 | Program 9 (Temperatures) | Input: `0` | Output: `Cold` ($0 < 60$). |
| 37 | Program 9 (Temperatures) | Input: `-15` | Output: `Cold` (negative high temperatures are valid cold winter readings). |
| 38 | Program 9 (Temperatures) | Input: `110` | Output: `Hot` ($110 \ge 85$). |
| 39 | Program 9 (Temperatures) | Input: (EOF immediately, 0 entries) | Output: Hot = `0`, Pleasant = `0`, Cold = `0`, Total = `0`. |
| 40 | Program 10 (Exam Scores) | Inputs: `98 87 86 85 85 78 73 72 72 72 70 66 63 50 -1` | Output: Total = `14`, A = `1`, B = `4`, C = `6`, D = `2`, F = `1`. Loop terminates at `-1`. |
| 41 | Program 10 (Exam Scores) | Input: `-1` (first input) | Output: Total = `0`, A = `0`, B = `0`, C = `0`, D = `0`, F = `0`. Clean termination without errors. |
| 42 | Program 10 (Exam Scores) | Input: `-99` | Output: Any negative integer acts as sentinel, terminating input immediately. |
| 43 | Program 10 (Exam Scores) | Inputs: `100 90 89 80 79 70 69 60 59 0 -1` | Output: Boundary verification: 100 (A), 90 (A), 89 (B), 80 (B), 79 (C), 70 (C), 69 (D), 60 (D), 59 (F), 0 (F). Total = `10`, A = `2`, B = `2`, C = `2`, D = `2`, F = `2`. |
| 44 | Program 10 (Exam Scores) | Inputs: `105 85 -1` | If invalid score $> 100$ entered, program should warn/ignore or reject $105$ and only process $85$ (B = 1, Total = 1). |

---

## Testing Strategy & Acceptance Criteria Verification

### 1. Program 6 Verification Vectors
| Date | Expected Output | Rationale |
|------|-----------------|-----------|
| 1 / 1 / 1994 | Day 1 | Standard start of non-leap year |
| 12 / 31 / 1993 | Day 365 | Standard end of non-leap year |
| 12 / 31 / 1996 | Day 366 | Leap year end ($1996 \pmod 4 == 0$) |
| 2 / 28 / 1900 | Day 59 | Century year, non-leap ($1900 \pmod{100} == 0, 1900 \pmod{400} \neq 0$) |
| 3 / 1 / 1900 | Day 60 | Century non-leap day following Feb 28 ($31 + 28 + 1$) |
| 2 / 29 / 2000 | Day 60 | Century leap day ($2000 \pmod{400} == 0$) |
| 3 / 1 / 2000 | Day 61 | Century leap day following Feb 29 ($31 + 29 + 1$) |

### 2. Program 7 Verification Vectors
| Input | Expected Output | Rationale |
|-------|-----------------|-----------|
| 2 | Prime | Smallest prime number |
| 7 | Prime | Prime ($> 1$, no factors) |
| 13 | Prime | Prime ($> 1$, no factors) |
| 4 | Composite | Divisible by 2 |
| 9 | Composite | Divisible by 3 |
| 15 | Composite | Divisible by 3 and 5 |
| 1 | Neither prime nor composite | Multiplicative unit |
| 0 | Neither prime nor composite | Zero |
| -5 | Neither prime nor composite | Negative integer |

### 3. Program 8 Verification Vectors
| Inputs | Expected Output | Rationale |
|--------|-----------------|-----------|
| 54, 24 | 6 | $54 = 6 \times 9, 24 = 6 \times 4$ |
| 24, 54 | 6 | Commutative property of GCD |
| 17, 19 | 1 | Distinct prime numbers |
| 0, 15 | 15 | Identity with zero |
| -54, 24 | 6 | Negative number absolute value normalization |

### 4. Program 9 Verification Vectors
| Input Dataset | Expected Counts | Rationale |
|---------------|-----------------|-----------|
| 25 sample temperatures (`55 62 68 74 59 45 41 58 60 67 65 78 82 88 91 92 90 93 87 78 79 72 68 61 59 -99`) | Hot: 6, Pleasant: 13, Cold: 6, Total: 25 | Hot: 88, 91, 92, 90, 93, 87 (6 values)<br>Pleasant: 62, 68, 74, 60, 67, 65, 78, 82, 78, 79, 72, 68, 61 (13 values)<br>Cold: 55, 59, 45, 41, 58, 59 (6 values) |
| `85 84 60 59 -99` | Hot: 1, Pleasant: 2, Cold: 1, Total: 4 | Boundary coverage |

### 5. Program 10 Verification Vectors
| Input Dataset | Expected Counts | Rationale |
|---------------|-----------------|-----------|
| `98 87 86 85 85 78 73 72 72 72 70 66 63 50 -1` | Total: 14, A: 1, B: 4, C: 6, D: 2, F: 1 | Acceptance criteria match |
| `-1` | Total: 0, A: 0, B: 0, C: 0, D: 0, F: 0 | Immediate termination |
| `100 90 89 80 79 70 69 60 59 0 -1` | Total: 10, A: 2, B: 2, C: 2, D: 2, F: 2 | Every bucket boundary hit |
