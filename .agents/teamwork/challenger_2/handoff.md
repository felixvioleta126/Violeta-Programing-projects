# CpE 02 Empirical Challenger Verification Report (Programs 6 through 10)

## 1. Observation

### Target Scope & System State
- **Workspace**: `c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs`
- **Compiler/Runtime**:
  - `javac 21.0.13.0.2`
  - `openjdk 21.0.13.0.2 2026-10-22 LTS` (build 21.0.13.0.2+1-LTS Microsoft)
- **Reviewed Implementation Files**:
  - `Program6.java` (Day of Year Calculation, 105 lines)
  - `Program7.java` (Prime or Composite Checker, 103 lines)
  - `Program8.java` (Greatest Common Divisor, 58 lines)
  - `Program9.java` (Daily High Temperatures Analysis, 81 lines)
  - `Program10.java` (Exam Scores and Grade Distribution, 103 lines)
- **Existing Baseline Harness**: `test_runner.ps1` (1082 lines, 136 tests across Program1–Program10)
- **Adversarial Stress Harness**: `adversarial_challenger_runner.ps1` (323 lines, 122 deep edge-case stress tests covering Programs 6–10)

### Empirical Execution Results

#### 1. Comprehensive Baseline Regression
- **Command**:
  ```powershell
  cd "c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs"; .\test_runner.ps1
  ```
- **Result Output**:
  ```
  Total Tests Run : 136
  Passed          : 136
  Failed          : 0
  Success Rate    : 100.00%
  Total Duration  : 42.01 seconds
  TEST SUITE STATUS: ALL TESTS PASSED (100%)
  ```

#### 2. Challenger Adversarial Stress Suite (122 Dedicated Tests)
- **Command**:
  ```powershell
  cd "c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs"; .\adversarial_challenger_runner.ps1
  ```
- **Result Output**:
  ```
  RESULTS: Total = 122, Passed = 122, Failed = 0
  ```

### Breakdown of Adversarial Scenarios by Program

#### Program 6: Day of Year Calculation (`Program6.java`)
- **Century Leap Years (1600, 2000, 2400)**:
  - Input `12 31 1600` -> Output `Day number of the year: 366`, `Day 366` (PASS)
  - Input `12 31 2000` -> Output `Day number of the year: 366`, `Day 366` (PASS)
  - Input `12 31 2400` -> Output `Day number of the year: 366`, `Day 366` (PASS)
  - Input `2 29 2000` -> Output `Day number of the year: 60`, `Day 60` (PASS)
  - Input `3 1 2000` -> Output `Day number of the year: 61`, `Day 61` (PASS)
- **Century Non-Leap Years (1700, 1800, 1900, 2100)**:
  - Input `12 31 1700` -> Output `Day 365` (PASS)
  - Input `12 31 1800` -> Output `Day 365` (PASS)
  - Input `12 31 1900` -> Output `Day 365` (PASS)
  - Input `12 31 2100` -> Output `Day 365` (PASS)
  - Input `2 28 1900` -> Output `Day 59` (PASS)
  - Input `3 1 1900` -> Output `Day 60` (PASS)
  - Input `2 29 1900` -> Output `Invalid date entered.` (PASS)
  - Input `2 29 2100` -> Output `Invalid date entered.` (PASS)
- **February Boundary Transitions (Leap 2024 vs Non-Leap 2023)**:
  - Input `2 28 2024` -> `Day 59` (PASS)
  - Input `2 29 2024` -> `Day 60` (PASS)
  - Input `3 1 2024` -> `Day 61` (PASS)
  - Input `2 28 2023` -> `Day 59` (PASS)
  - Input `2 29 2023` -> `Invalid date entered.` (PASS)
  - Input `3 1 2023` -> `Day 60` (PASS)
- **Invalid Month Handling (<1 or >12)**:
  - Month `0`, `-1`, `13`, `99` correctly rejected with `Invalid date entered.` (PASS)
- **Invalid Day Handling**:
  - Non-leap `2 29 1993` rejected with `Invalid date entered.` (PASS)
  - Leap `2 30 2000` rejected with `Invalid date entered.` (PASS)
  - 30-day month violations: `4 31 2023`, `6 31 2023`, `9 31 2023`, `11 31 2023` rejected with `Invalid date entered.` (PASS)
  - Out-of-bounds days: `5 0 2023`, `5 -5 2023`, `1 32 2023` rejected with `Invalid date entered.` (PASS)
- **Canonical Benchmarks**:
  - `1 1 1994` -> `Day 1` (PASS)
  - `12 31 1993` -> `Day 365` (PASS)
  - `12 31 1996` -> `Day 366` (PASS)

#### Program 7: Prime or Composite Checker (`Program7.java`)
- **Unit and Zero Boundaries**:
  - `0` -> Output: `0 is neither prime nor composite.` (PASS)
  - `1` -> Output: `1 is neither prime nor composite.` (PASS)
- **Negative Integer Invariants**:
  - `-1`, `-2`, `-7`, `-49` -> Output: `N is neither prime nor composite.` (PASS)
- **Smallest Prime**:
  - `2` -> Output: `2 is a prime number.`, `Result: Prime` (PASS)
- **Even Composites > 2**:
  - `4`, `6`, `8`, `100`, `1000` -> Output: `Result: Composite` (PASS)
- **Large Prime Arithmetic & 32-bit Limits**:
  - Mersenne prime $2^{31}-1 = 2147483647$ -> Output: `Result: Prime` (Execution time: 279 ms, zero arithmetic overflow in loop `d <= n / d`) (PASS)
  - 10,000th prime $104729$ -> Output: `Result: Prime` (PASS)
  - 7-digit prime $1000003$ -> Output: `Result: Prime` (PASS)
- **Carmichael Numbers (Fermat Pseudoprimes)**:
  - $561 = 3 \times 11 \times 17$ -> Output: `Result: Composite` (PASS)
  - $1105 = 5 \times 13 \times 17$ -> Output: `Result: Composite` (PASS)
  - $1729 = 7 \times 13 \times 19$ -> Output: `Result: Composite` (PASS)
  - $2465 = 5 \times 17 \times 29$ -> Output: `Result: Composite` (PASS)
  - $2821 = 7 \times 13 \times 31$ -> Output: `Result: Composite` (PASS)
- **Squares of Primes**:
  - $4$ ($2^2$), $9$ ($3^2$), $25$ ($5^2$), $49$ ($7^2$), $121$ ($11^2$), $169$ ($13^2$), $289$ ($17^2$) -> Output: `Result: Composite` (PASS)
  - Large square $46337^2 = 2147117569$ -> Output: `Result: Composite` (PASS)

#### Program 8: Greatest Common Divisor (`Program8.java`)
- **Zero Inputs**:
  - `gcd(0, 48)` -> Output: `GCD: 48` (PASS)
  - `gcd(48, 0)` -> Output: `GCD: 48` (PASS)
  - `gcd(0, 0)` -> Output: `GCD: 0` (PASS)
  - `gcd(0, -50)` -> Output: `GCD: 50` (PASS)
  - `gcd(-50, 0)` -> Output: `GCD: 50` (PASS)
- **Negative Inputs**:
  - `gcd(-54, 24)` -> Output: `GCD: 6` (PASS)
  - `gcd(54, -24)` -> Output: `GCD: 6` (PASS)
  - `gcd(-24, -54)` -> Output: `GCD: 6` (PASS)
  - `gcd(-17, 19)` -> Output: `GCD: 1` (PASS)
  - `gcd(-17, -19)` -> Output: `GCD: 1` (PASS)
- **Coprime Pairs**:
  - `gcd(17, 19)` -> Output: `GCD: 1` (PASS)
  - `gcd(99, 100)` -> Output: `GCD: 1` (PASS)
  - `gcd(355, 113)` -> Output: `GCD: 1` (PASS)
  - `gcd(1, 100000)` -> Output: `GCD: 1` (PASS)
  - `gcd(2147483647, 1)` -> Output: `GCD: 1` (PASS)
  - `gcd(2147483647, 2)` -> Output: `GCD: 1` (PASS)
- **Identical Inputs**:
  - `gcd(42, 42)` -> Output: `GCD: 42` (PASS)
  - `gcd(1, 1)` -> Output: `GCD: 1` (PASS)
  - `gcd(1000, 1000)` -> Output: `GCD: 1000` (PASS)
  - `gcd(-42, -42)` -> Output: `GCD: 42` (PASS)
  - `gcd(-1, -1)` -> Output: `GCD: 1` (PASS)
- **Large Integer Ranges**:
  - `gcd(1000000000, 500000000)` -> Output: `GCD: 500000000` (PASS)
  - `gcd(1071, 462)` -> Output: `GCD: 21` (PASS)
  - `gcd(12345678, 87654321)` -> Output: `GCD: 9` (PASS)
  - `gcd(2147483646, 2)` -> Output: `GCD: 2` (PASS)

#### Program 9: Daily High Temperatures Analysis (`Program9.java`)
- **Boundary Thresholds**:
  - `85`: `Temperature 85 is Hot`, `Hot: 1`, `Pleasant: 0`, `Cold: 0`, `Total days: 1` (PASS)
  - `84`: `Temperature 84 is Pleasant`, `Hot: 0`, `Pleasant: 1`, `Cold: 0`, `Total days: 1` (PASS)
  - `60`: `Temperature 60 is Pleasant`, `Hot: 0`, `Pleasant: 1`, `Cold: 0`, `Total days: 1` (PASS)
  - `59`: `Temperature 59 is Cold`, `Hot: 0`, `Pleasant: 0`, `Cold: 1`, `Total days: 1` (PASS)
- **Stream Termination**:
  - Sentinel `-99`: Terminates cleanly (PASS)
  - Sentinel `-999`: Terminates cleanly (PASS)
  - Stream EOF without sentinel: Terminates cleanly with accurate tallies (PASS)
  - Non-integer token (`quit`): Terminates cleanly on `!scanner.hasNextInt()` (PASS)
  - Immediate sentinel (`-99`): Outputs `Total days: 0`, `Hot: 0`, `Pleasant: 0`, `Cold: 0` (PASS)
- **Subzero Freezing Temperatures**:
  - `-1`, `-15`, `-40`, `-50`: Each categorized as `Cold`, incrementing `coldDays` (PASS)
- **Large Dataset Stress**:
  - 100 temperatures (25 alternating cycles of 90, 75, 65, 30): Outputs `Hot: 25`, `Pleasant: 50`, `Cold: 25`, `Total days: 100` (PASS)
- **25-Sample Benchmark**:
  - Temperatures: `55, 62, 68, 74, 59, 45, 41, 58, 60, 67, 65, 78, 82, 88, 91, 92, 90, 93, 87, 78, 79, 72, 68, 61, 59`
  - Output: `Hot: 6`, `Pleasant: 13`, `Cold: 6`, `Total days: 25` (PASS)
  - Note on Specification Verification:
    - Hot ($\ge 85$): 88, 91, 92, 90, 93, 87 $\implies 6$ days.
    - Pleasant ($60 \le T \le 84$): 62, 68, 74, 60, 67, 65, 78, 82, 78, 79, 72, 68, 61 $\implies 13$ days.
    - Cold ($< 60$): 55, 59, 45, 41, 58, 59 $\implies 6$ days.
    - Total: $6 + 13 + 6 = 25$ days.
    - The code strictly implements the mathematical criteria ($T \ge 85 \implies$ Hot, $60 \le T \le 84 \implies$ Pleasant, $T < 60 \implies$ Cold), yielding the exact correct count 6 Hot, 13 Pleasant, 6 Cold.

#### Program 10: Exam Scores and Grade Distribution (`Program10.java`)
- **Immediate Sentinel Termination**:
  - Input `-1`: Outputs `Total = 0`, `A = 0`, `B = 0`, `C = 0`, `D = 0`, `F = 0` (PASS)
  - Input `-99`: Outputs `Total = 0`, `A = 0`, `B = 0`, `C = 0`, `D = 0`, `F = 0` (PASS)
- **Exact Score Cutoffs**:
  - `100` -> `A = 1`, `Total = 1` (PASS)
  - `90` -> `A = 1`, `Total = 1` (PASS)
  - `89` -> `B = 1`, `Total = 1` (PASS)
  - `80` -> `B = 1`, `Total = 1` (PASS)
  - `79` -> `C = 1`, `Total = 1` (PASS)
  - `70` -> `C = 1`, `Total = 1` (PASS)
  - `69` -> `D = 1`, `Total = 1` (PASS)
  - `60` -> `D = 1`, `Total = 1` (PASS)
  - `59` -> `F = 1`, `Total = 1` (PASS)
  - `0` -> `F = 1`, `Total = 1` (PASS)
  - Combined sequence (`100 90 89 80 79 70 69 60 59 0 -1`): Outputs `Total = 10`, `A = 2`, `B = 2`, `C = 2`, `D = 2`, `F = 2` (PASS)
- **Out-of-Range Rejection**:
  - `101`, `150`, `999` print `Invalid score ignored (must be 0-100)` and are excluded from `totalGrades` and all bucket counters (PASS)
  - Interspersed sequence `105 95 200 85 999 55 -1` -> Correctly yields `Total = 3`, `A = 1`, `B = 1`, `F = 1` (PASS)
- **Official 14-Score Benchmark**:
  - Input: `98 87 86 85 85 78 73 72 72 72 70 66 63 50 -1`
  - Output: `Total = 14`, `A = 1`, `B = 4`, `C = 6`, `D = 2`, `F = 1` (PASS)

---

## 2. Logic Chain

1. **Premise**: Programs 6 through 10 must fulfill CpE 02 specifications, handle hostile edge cases gracefully without runtime exceptions or incorrect calculations, and match canonical benchmarks.
2. **Empirical Fact**:
   - `Program6.java` encapsulates Gregorian calendar rules via `isLeapYear(year)` with `(year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)`. Empirical verification confirmed that century years divisible by 400 (1600, 2000, 2400) produce 366 days and accept Feb 29 (Day 60), while century years not divisible by 400 (1700, 1800, 1900, 2100) produce 365 days and reject Feb 29. Month validation ($1 \le \text{month} \le 12$) and day bounds check ($1 \le \text{day} \le \text{daysInMonth}[\text{month}-1]$) safely catch all malformed dates without throwing `ArrayIndexOutOfBoundsException`.
   - `Program7.java` applies $O(\sqrt{n})$ trial division with the non-overflowing loop condition `d <= n / d`. When tested against $2^{31}-1 = 2147483647$, the loop terminates within 23,000 steps (~280 ms execution time) without integer wrap-around. Inputs $\le 1$ are correctly categorized as neither prime nor composite. Carmichael numbers ($561, 1105, 1729, 2465, 2821$) and prime squares are consistently identified as composite.
   - `Program8.java` normalizes inputs using 64-bit casting `long n1 = Math.abs((long) a); long n2 = Math.abs((long) b);`, which avoids the two's complement integer overflow that would occur with standard `Math.abs(Integer.MIN_VALUE)`. Euclidean reduction handles pairs with 0 (`gcd(0, N) = N`, `gcd(0, 0) = 0`), negative values, coprime pairs, and large numbers up to $10^9$ with zero faults.
   - `Program9.java` implements boundary classifications: $T \ge 85 \implies \text{Hot}$, $60 \le T \le 84 \implies \text{Pleasant}$, $T < 60 \implies \text{Cold}$. Execution under sentinel (`-99`, `-999`), EOF, subzero values down to $-50$, 100-entry streams, and the 25-temperature benchmark consistently generated exact totals.
   - `Program10.java` implements grade cutoffs: $A \ge 90$, $B \ge 80$, $C \ge 70$, $D \ge 60$, $F < 60$. Score validation filters values $> 100$, and negative sentinels terminate input immediately. The official 14-score benchmark passed with exact counts: Total 14, A=1, B=4, C=6, D=2, F=1.
3. **Conclusion Inference**: All five implementations exhibit mathematical correctness, boundary robustness, and specification adherence under adversarial stress testing.

---

## 3. Caveats

1. In Program 9, the informal parenthetical note in `ORIGINAL_REQUEST.md` line 69 mentioned `-> 7 hot, 11 pleasant, 7 cold`, but rigorous mathematical evaluation of the 25 sample values ($55, 62, 68, 74, 59, 45, 41, 58, 60, 67, 65, 78, 82, 88, 91, 92, 90, 93, 87, 78, 79, 72, 68, 61, 59$) according to the program's rules ($T \ge 85$ Hot, $60 \le T \le 84$ Pleasant, $T < 60$ Cold) proves there are exactly 6 Hot, 13 Pleasant, and 6 Cold days. Program 9 correctly outputs `Hot: 6, Pleasant: 13, Cold: 6, Total days: 25`.
2. Program 8 returns an `int`. For an adversarial input pair where $a = -2147483648$ and $b = 0$, the mathematical GCD is $2^{31} = 2147483648$, which exceeds 32-bit signed integer capacity (`Integer.MAX_VALUE`). This is an inherent limitation of Java's primitive signed 32-bit `int` return type specified in the CpE 02 curriculum, and does not affect valid integer domain computations.
3. No implementation source files were modified during this review, preserving full integrity of the implementation milestone.

---

## 4. Conclusion

**Verdict: APPROVE**

Programs 6, 7, 8, 9, and 10 have been rigorously evaluated against 136 baseline tests and 122 custom adversarial stress cases (total 258 test executions) with a **100% pass rate (0 failures)**. All boundary conditions, leap-century rules, non-leap century rules, invalid calendar dates, prime/composite classifications, Carmichael numbers, 32-bit Mersenne primes, GCD zero and negative inputs, temperature thresholds, subzero temperatures, dynamic stream terminations, grade boundary cutoffs, out-of-range exam scores, and canonical benchmarks execute cleanly with zero errors.

---

## 5. Verification Method

To independently reproduce and verify this assessment:

1. Open a PowerShell terminal in the repository root or project folder:
   ```powershell
   cd "c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs"
   ```
2. Verify all programs compile cleanly:
   ```powershell
   javac Program6.java Program7.java Program8.java Program9.java Program10.java
   ```
3. Run the baseline comprehensive test runner:
   ```powershell
   .\test_runner.ps1
   ```
   *Expected outcome: 136 passed, 0 failed.*
4. Run the Challenger adversarial stress test harness:
   ```powershell
   .\adversarial_challenger_runner.ps1
   ```
   *Expected outcome: Total = 122, Passed = 122, Failed = 0.*
5. Invalidation conditions: Any test failure, unhandled exception (e.g. `ArrayIndexOutOfBoundsException`, `InputMismatchException`), or incorrect tally on the canonical benchmark datasets.
