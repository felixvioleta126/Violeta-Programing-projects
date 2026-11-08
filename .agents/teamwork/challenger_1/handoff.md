# Empirical Adversarial Challenge Report: Programs 1 to 5

**Author**: `challenger_1` (Critic / Specialist)  
**Date**: 2026-11-01  
**Scope**: Adversarial stress testing of `Program1.java` through `Program5.java` in `c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs`  
**Verdict**: **APPROVE**  
**Risk Assessment**: **LOW**

---

## 1. Observation

Direct empirical observations were gathered by executing the adversarial test harness `cpe02_java_programs\challenger_stress_harness.ps1` against the compiled Java classes using OpenJDK 21 (`21.0.13.0.2+1-LTS`). Standard input was redirected to each process with strict 5000 ms timeout enforcement.

### Test Execution Summary
- **Total Adversarial Tests Executed**: 60
- **Passed**: 60 (100.0%)
- **Failed**: 0 (0.0%)
- **Timeouts**: 0
- **Mean Process Duration**: ~175 ms per test

### Verbatim Observations by Program

#### Program 1: Arithmetic Sequence (`Program1.java:20-75`)
1. **ADV-P1-01 (Zero Difference)**:
   - Input: `15\n0\n`
   - Output: `15 15 15 15 15 15 15 15 15 15 15 15 15 15 15 15`
   - Element count verified: exactly 16 tokens, all equal to 15.
2. **ADV-P1-02 (Negative Difference)**:
   - Input: `100\n-7\n`
   - Output: `100 93 86 79 72 65 58 51 44 37 30 23 16 9 2 -5`
   - Element count verified: exactly 16 tokens; arithmetic formula $100 + i \times (-7)$ verified for all $i \in [0, 15]$.
3. **ADV-P1-03 (Zero Starting Value)**:
   - Input: `0\n12\n`
   - Output: `0 12 24 36 48 60 72 84 96 108 120 132 144 156 168 180`
   - Element count verified: exactly 16 tokens; sequence strictly follows $12 \times i$.
4. **ADV-P1-04 (All Zeroes)**:
   - Input: `0\n0\n`
   - Output: `0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0`
   - Element count verified: exactly 16 zeroes.
5. **ADV-P1-05 (Large Numbers - Millions)**:
   - Input: `1000000\n500000\n`
   - Output: `1000000 1500000 2000000 2500000 3000000 3500000 4000000 4500000 5000000 5500000 6000000 6500000 7000000 7500000 8000000 8500000`
   - Element count verified: exactly 16 tokens.
6. **ADV-P1-06 (Negative Start & Difference)**:
   - Input: `-50\n-25\n`
   - Output: `-50 -75 -100 -125 -150 -175 -200 -225 -250 -275 -300 -325 -350 -375 -400 -425`
   - Element count verified: exactly 16 tokens.

#### Program 2: Min/Max and Sorting (`Program2.java:19-137`)
1. **ADV-P2-01 (Identical Elements)**:
   - Input: `42 42 42 42 42`
   - Output: `Lowest (Min) number: 42`, `Highest (Max) number: 42`, `Ascending order: 42 42 42 42 42`, `Descending order: 42 42 42 42 42`.
2. **ADV-P2-02 (All Negatives)**:
   - Input: `-100 -20 -5 -80 -1`
   - Output: `Lowest (Min) number: -100`, `Highest (Max) number: -1`, `Ascending order: -100 -80 -20 -5 -1`, `Descending order: -1 -5 -20 -80 -100`.
3. **ADV-P2-03 (Pre-sorted Ascending)**:
   - Input: `10 20 30 40 50`
   - Output: `Lowest (Min) number: 10`, `Highest (Max) number: 50`, `Ascending order: 10 20 30 40 50`, `Descending order: 50 40 30 20 10`.
4. **ADV-P2-04 (Pre-sorted Descending)**:
   - Input: `99 77 55 33 11`
   - Output: `Lowest (Min) number: 11`, `Highest (Max) number: 99`, `Ascending order: 11 33 55 77 99`, `Descending order: 99 77 55 33 11`.
5. **ADV-P2-05 (Multiple Duplicates)**:
   - Input: `3 5 3 5 3`
   - Output: `Lowest (Min) number: 3`, `Highest (Max) number: 5`, `Ascending order: 3 3 3 5 5`, `Descending order: 5 5 3 3 3`.
6. **ADV-P2-06 (Extreme 32-bit Integer Values)**:
   - Input: `-2147483648 2147483647 0 -1 1`
   - Output: `Lowest (Min) number: -2147483648`, `Highest (Max) number: 2147483647`, `Ascending order: -2147483648 -1 0 1 2147483647`, `Descending order: 2147483647 1 0 -1 -2147483648`.
   - Observation: Bubble sort uses direct `>` and `<` relational operators, avoiding subtraction-based comparison integer overflow (`a - b`).

#### Program 3: Number System Converter Using Arrays (`Program3.java:24-121`)
1. **ADV-P3-01 to ADV-P3-03 (Zero Input)**:
   - Input: `0` with choices `1`, `2`, `3`
   - Outputs: `Binary: 0`, `Octal: 0`, `Hexadecimal: 0`.
2. **ADV-P3-04 to ADV-P3-06 (Powers of 2)**:
   - Input: `256` choice `1` $\rightarrow$ `Binary: 100000000`
   - Input: `1024` choice `2` $\rightarrow$ `Octal: 2000`
   - Input: `65536` choice `3` $\rightarrow$ `Hexadecimal: 10000`
3. **ADV-P3-07 to ADV-P3-09 (Boundary Hex Digits 10-15 $\rightarrow$ A-F)**:
   - Input: `15` choice `3` $\rightarrow$ `Hexadecimal: F`
   - Input: `10` choice `3` $\rightarrow$ `Hexadecimal: A`
   - Input: `175` choice `3` $\rightarrow$ `Hexadecimal: AF`
4. **ADV-P3-10 to ADV-P3-12 (Large Numbers)**:
   - Input: `65535` choice `3` $\rightarrow$ `Hexadecimal: FFFF`
   - Input: `1000000` choice `3` $\rightarrow$ `Hexadecimal: F4240`
   - Input: `2147483647` (Integer.MAX_VALUE) choice `3` $\rightarrow$ `Hexadecimal: 7FFFFFFF`
5. **ADV-P3-13 (Negative Decimal Rejection)**:
   - Input: `-25`
   - Output: `Error: Value must be positive.`
6. **ADV-P3-14 to ADV-P3-15 (Invalid Option Handling)**:
   - Input: `14` choice `0` $\rightarrow$ `Error: Invalid choice.`
   - Input: `14` choice `4` $\rightarrow$ `Error: Invalid choice.`

#### Program 4: Triangle Classification (`Program4.java:23-77`)
1. **ADV-P4-01 to ADV-P4-03 (Degenerate Triangles $a+b=c$)**:
   - Input: `1 2 3` $\rightarrow$ `The given sides do not form a valid triangle.`
   - Input: `3 1 2` $\rightarrow$ `The given sides do not form a valid triangle.`
   - Input: `5 5 10` $\rightarrow$ `The given sides do not form a valid triangle.`
2. **ADV-P4-04 (Collinear / Impossible Triangle)**:
   - Input: `1 2 10` $\rightarrow$ `The given sides do not form a valid triangle.`
3. **ADV-P4-05 to ADV-P4-07 (Zero Side Length Rejection)**:
   - Input: `0 5 5` $\rightarrow$ `The given sides do not form a valid triangle.`
   - Input: `5 0 5` $\rightarrow$ `The given sides do not form a valid triangle.`
   - Input: `0 0 0` $\rightarrow$ `The given sides do not form a valid triangle.`
4. **ADV-P4-08 to ADV-P4-09 (Negative Side Length Rejection)**:
   - Input: `-3 4 5` $\rightarrow$ `The given sides do not form a valid triangle.`
   - Input: `-5 -5 -5` $\rightarrow$ `The given sides do not form a valid triangle.`
5. **ADV-P4-10 to ADV-P4-12 (Isosceles Permutations)**:
   - Input: `5 5 3` ($a=b$) $\rightarrow$ `The triangle is Isosceles.`
   - Input: `3 5 5` ($b=c$) $\rightarrow$ `The triangle is Isosceles.`
   - Input: `5 3 5` ($a=c$) $\rightarrow$ `The triangle is Isosceles.`
6. **ADV-P4-13 to ADV-P4-14 (Large Side Ratios)**:
   - Input: `1000000 1000000 1` $\rightarrow$ `The triangle is Isosceles.`
   - Input: `1000000 999999 2` $\rightarrow$ `The triangle is Scalene.`
7. **ADV-P4-15 (Equilateral Verification)**:
   - Input: `777 777 777` $\rightarrow$ `The triangle is Equilateral.`

#### Program 5: Palindrome Number Checker (`Program5.java:20-57`)
1. **ADV-P5-01 to ADV-P5-03 (Single Digits)**:
   - Input: `0` $\rightarrow$ `0 is a palindrome.`
   - Input: `7` $\rightarrow$ `7 is a palindrome.`
   - Input: `9` $\rightarrow$ `9 is a palindrome.`
2. **ADV-P5-04 to ADV-P5-05 (Symmetric Numbers with Zeroes)**:
   - Input: `101` $\rightarrow$ `101 is a palindrome.`
   - Input: `10001` $\rightarrow$ `10001 is a palindrome.`
3. **ADV-P5-06 to ADV-P5-07 (Trailing Zero Asymmetry)**:
   - Input: `10` $\rightarrow$ `10 is not a palindrome.`
   - Input: `1200` $\rightarrow$ `1200 is not a palindrome.`
4. **ADV-P5-08 to ADV-P5-09 (Negative Numbers)**:
   - Input: `-121` $\rightarrow$ `-121 is not a palindrome.`
   - Input: `-7` $\rightarrow$ `-7 is not a palindrome.`
5. **ADV-P5-10 to ADV-P5-15 (Large Integers 10 to 19 Digits)**:
   - Input: `1000000001` (10 digits) $\rightarrow$ `1000000001 is a palindrome.`
   - Input: `12345654321` (11 digits) $\rightarrow$ `12345654321 is a palindrome.`
   - Input: `123456787654321` (15 digits) $\rightarrow$ `123456787654321 is a palindrome.`
   - Input: `100000000000000001` (18 digits) $\rightarrow$ `100000000000000001 is a palindrome.`
   - Input: `1000000000000000001` (19 digits) $\rightarrow$ `1000000000000000001 is a palindrome.`
   - Input: `1234567890987654321` (19 digits) $\rightarrow$ `1234567890987654321 is a palindrome.`
6. **ADV-P5-16 to ADV-P5-18 (Non-Palindromes & Overflow Boundaries)**:
   - Input: `1234567890123456789` (19 digits) $\rightarrow$ `1234567890123456789 is not a palindrome.`
   - Input: `9223372036854775807` (`Long.MAX_VALUE`) $\rightarrow$ `9223372036854775807 is not a palindrome.`
   - Input: `1000000000000000009` (19 digits, naive reverse would overflow 64-bit signed int) $\rightarrow$ `1000000000000000009 is not a palindrome.`

---

## 2. Logic Chain

1. **Premise 1 (CpE 02 Curriculum & Specification Adherence)**:
   - Per `ORIGINAL_REQUEST.md` (§R1-R5, §R11) and `PROJECT.md`, Programs 1-5 must implement the required logic using standard control structures (decision, repetition, branching) and basic arrays without external libraries.
2. **Premise 2 (Program 1 Robustness)**:
   - `Program1.java` allocates `new int[16]` and calculates each term as `first + (i * diff)`.
   - In all tests (ADV-P1-01 through ADV-P1-06), the output was parsed into individual tokens. In every case, exactly 16 tokens were emitted and each token strictly matched the arithmetic progression. Zero difference, negative difference, zero starting value, and large values (millions) did not produce off-by-one errors or truncation.
3. **Premise 3 (Program 2 Sorting & Extremes)**:
   - `Program2.java` implements manual bubble sort without modifying the original input array.
   - Crucially, comparisons are performed via `sorted[j] > sorted[j + 1]` (ascending) and `sorted[j] < sorted[j + 1]` (descending) rather than arithmetic subtraction `sorted[j] - sorted[j + 1]`.
   - Because relational operators were used, testing with `Integer.MIN_VALUE` (-2147483648) and `Integer.MAX_VALUE` (2147483647) sorted correctly without two's complement subtraction overflow.
   - Identical elements, all-negative values, pre-sorted inputs, and duplicate clusters all produced verified ascending and descending sequences.
4. **Premise 4 (Program 3 Number Base Conversions)**:
   - `Program3.java` validates `decimal < 0` and rejects negative values.
   - For `decimal == 0`, it returns `new String(new char[]{'0'})`, correctly emitting `0` across Binary, Octal, and Hexadecimal.
   - Digits are stored in `char[64]` and reversed into a sized result array. The 64-char buffer safely accommodates up to 63 binary digits, well above the 31 bits of positive 32-bit integers (`Integer.MAX_VALUE` tested in ADV-P3-12 emitted `7FFFFFFF`).
   - Boundary hexadecimal digits 10 through 15 are mapped to `A` through `F` through the lookup array `hexSymbols`.
   - Invalid menu selections (e.g., choice 0, choice 4) are explicitly handled with error messaging.
5. **Premise 5 (Program 4 Triangle Classification)**:
   - `Program4.java` enforces strict triangle inequality: `(a + b > c) && (a + c > b) && (b + c > a)` and positivity `a > 0 && b > 0 && c > 0`.
   - Degenerate cases ($a+b=c$, e.g. `1 2 3`, `3 1 2`, `5 5 10`) are strictly rejected as invalid triangles.
   - Zero and negative side lengths are caught by the non-positive check.
   - All permutations of isosceles equality ($a=b$, $b=c$, $a=c$) correctly classify as `Isosceles`.
   - Extreme side ratios (e.g. 1,000,000 : 1,000,000 : 1) classify correctly without floating-point precision collapse.
6. **Premise 6 (Program 5 Palindrome Checker)**:
   - `Program5.java` uses `long` data type for 64-bit integer inputs up to 19 digits.
   - Negative numbers immediately return `false` per specification.
   - Single-digit inputs (0, 7, 9) return `true`.
   - Arithmetic reversal `reversed = (reversed * 10) + digit` accurately reconstructs reversed numbers up to 19 digits (e.g. `1000000000000000001`, `1234567890987654321`).
   - For non-palindromes where digit reversal might exceed 64-bit signed maximum, the two's complement overflow yields a negative value which is never equal to the positive input `original`, thereby safely preserving the correct verdict (`is not a palindrome`).

---

## 3. Caveats

1. **Floating Point Rounding in Program 4**: `Program4.java` accepts `double` inputs for sides. Standard IEEE 754 floating point arithmetic applies. Extremely subtle epsilon differences (e.g. $10^{-16}$) could theoretically affect floating-point comparisons if users enter high-precision non-integers, but within normal educational and practical numeric inputs, all classifications are exact.
2. **Scanner Tokenization**: All programs assume standard numeric tokens provided via whitespace/newline delimiters. Inputs exceeding Java primitive ranges (e.g. >20 digits for `nextLong()`) would trigger `java.util.InputMismatchException` from `Scanner`, which is standard Java SE console behavior.
3. No other caveats.

---

## 4. Conclusion

All 5 programs (`Program1.java` through `Program5.java`) demonstrate complete algorithmic correctness, numerical stability, boundary resilience, and strict compliance with the CpE 02 specifications in `ORIGINAL_REQUEST.md` and `PROJECT.md`.

- **Verdict**: **APPROVE**
- **Action**: No code changes required for Programs 1 through 5. They are verified and certified ready for milestone completion.

---

## 5. Verification Method

To independently reproduce and verify this empirical challenge:

1. Open PowerShell in the workspace root.
2. Execute the test runner:
   ```powershell
   powershell -ExecutionPolicy Bypass -File "c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs\challenger_stress_harness.ps1"
   ```
3. Inspect `c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs\challenger_results.json` to review individual inputs, outputs, timestamps, and pass statuses.
4. Run the full regression test runner to verify cross-program compatibility:
   ```powershell
   powershell -ExecutionPolicy Bypass -File "c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs\test_runner.ps1"
   ```
5. Invalidation conditions: If any test in `challenger_stress_harness.ps1` returns non-zero exit code or fails any assertion, the APPROVE verdict is immediately invalidated.
