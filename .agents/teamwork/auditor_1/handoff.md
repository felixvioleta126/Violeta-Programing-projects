# Forensic Integrity Audit Report & Handoff

## Forensic Audit Report

**Work Product**: `c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs` (`Program1.java` through `Program10.java`)  
**Profile**: General Project (Demo Mode)  
**Verdict**: **CLEAN** (Zero Integrity Violations)

---

### Phase Results

| Check Item | Description | Result | Details |
|---|---|:---:|---|
| **Phase 1: Hardcoded Test Results** | Detect pre-baked outputs matching test inputs | **PASS** | Grep searches for test numbers (`21`, `5`, `14`, `42`, `1994`, `98`) confirmed zero hardcoded benchmark responses. |
| **Phase 1: Facade Implementations** | Detect dummy methods or stub implementations | **PASS** | Every method in `Program1.java` through `Program10.java` implements full, genuine algorithms. |
| **Phase 1: Pre-populated Artifacts** | Check for pre-existing logs, result, or output files | **PASS** | Zero pre-populated `.log`, `*result*`, or `*output*` artifacts found in workspace. |
| **Phase 1: Prohibited Library Check** | Verify NO disallowed external/framework features | **PASS** | Grep analysis confirmed all 10 programs import exclusively `java.util.Scanner`. Zero usage of `Arrays.sort()`, `Integer.toBinaryString()`, `Integer.toHexString()`, `Integer.toOctalString()`, `StringBuilder.reverse()`, `java.time.*`, `BigInteger`, or `java.util.stream.*`. |
| **Phase 1: Control Structure Compliance** | CpE 02 R11 structure, block brackets, indentation | **PASS** | Strict adherence to standard sequence, selection (`if/else`, `switch`), repetition (`for`, `while`), branching (`break`, `return`), and explicit `{ }` blocks. |
| **Phase 2: Direct Recompilation** | `javac -Xlint:all -encoding UTF-8 *.java` | **PASS** | Clean exit (exit code 0), 0 warnings, 0 errors. |
| **Phase 2: Empirical CLI Validation** | Diverse interactive CLI input testing | **PASS** | Verified correct runtime computations on edge cases, negative numbers, zeroes, and boundary inputs. |
| **Phase 2: Automated Test Runner** | `test_runner.ps1` (Tiers 1–4) | **PASS** | 136/136 tests passed (100% pass rate) across all 10 programs. |

---

## 1. Observation

### 1.1 Source Code Inspection & Dependency Analysis
- **Imports across all programs**:
  Grep command: `grep "import " *.java`
  ```text
  Program1.java:1:import java.util.Scanner;
  Program2.java:1:import java.util.Scanner;
  Program3.java:1:import java.util.Scanner;
  Program4.java:1:import java.util.Scanner;
  Program5.java:1:import java.util.Scanner;
  Program6.java:1:import java.util.Scanner;
  Program7.java:1:import java.util.Scanner;
  Program8.java:1:import java.util.Scanner;
  Program9.java:1:import java.util.Scanner;
  Program10.java:1:import java.util.Scanner;
  ```
- **Prohibited method grep checks**:
  - `Arrays.sort`: Found 0 occurrences (only mentioned in Program2.java:9 javadoc as "without Arrays.sort()").
  - `toBinaryString`, `toOctalString`, `toHexString`: 0 occurrences.
  - `reverse(`: 0 occurrences.
  - `isProbablePrime`: 0 occurrences.
  - `stream`: 0 occurrences of Java stream API (only in Program9.java:46 prompt text "stream ends on EOF").
  - `java.time`: 0 occurrences.

### 1.2 Program-by-Program Algorithmic Analysis
1. **`Program1.java`** (Lines 20–36):
   Generates arithmetic sequence via genuine array iteration: `sequence[i] = first + (i * diff);` in a 16-element array. Space-separated printing without trailing space.
2. **`Program2.java`** (Lines 46–93):
   Implements manual Bubble Sort in both `sortAscending` and `sortDescending` with nested loops and variable swapping. `findMin` and `findMax` perform single-pass linear scans.
3. **`Program3.java`** (Lines 24–50):
   Implements manual base conversion via `% base` and `/ base` into `char[64]` digit array using lookup `hexSymbols = {'0'..'F'}`, followed by manual array reversal.
4. **`Program4.java`** (Lines 23–50):
   Validates triangle inequality `(a + b > c) && (a + c > b) && (b + c > a)` with strict positivity check `(a <= 0 || b <= 0 || c <= 0)`. Categorizes equilateral (`a == b && b == c`), isosceles, and scalene.
5. **`Program5.java`** (Lines 20–36):
   Reverses digits purely with integer arithmetic `% 10` and `/ 10` (`reversed = (reversed * 10) + digit;`). Negative numbers return `false`.
6. **`Program6.java`** (Lines 21–63):
   Implements Gregorian leap year rule `(year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)`. Accumulates days using `daysInMonth = {31, isLeap ? 29 : 28, ...}` and validates input boundaries.
7. **`Program7.java`** (Lines 21–60):
   Implements $O(\sqrt{n})$ trial division with odd steps `d += 2` and overflow prevention `d <= n / d`. Rejects $n \le 1$ as neither prime nor composite.
8. **`Program8.java`** (Lines 23–34):
   Implements Euclidean modulo algorithm with `Math.abs` normalization.
9. **`Program9.java`** (Lines 23–67):
   Iterates dynamic input via `while (scanner.hasNextInt())` categorizing each temperature (>=85 Hot, 60-84 Pleasant, <60 Cold) and increments tallies.
10. **`Program10.java`** (Lines 21–84):
    Accumulates grade tallies in `int[5]` array via `while (scanner.hasNextInt())`, terminates on negative sentinel (`score < 0`), ignores out-of-range scores (>100), maps scores to A/B/C/D/F using `switch`.

### 1.3 Key Forensic Discovery on Program 9 Authenticity
In `ORIGINAL_REQUEST.md` line 69, a sample sequence of 25 numbers was listed:
`55, 62, 68, 74, 59, 45, 41, 58, 60, 67, 65, 78, 82, 88, 91, 92, 90, 93, 87, 78, 79, 72, 68, 61, 59`
with a parenthetical assertion: `-> 7 hot, 11 pleasant, 7 cold`.
Manual mathematical audit of these 25 numbers reveals:
- Cold (< 60): 55, 59, 45, 41, 58, 59 -> Exactly 6 numbers.
- Hot (>= 85): 88, 91, 92, 90, 93, 87 -> Exactly 6 numbers.
- Pleasant (60 to 84): 62, 68, 74, 60, 67, 65, 78, 82, 78, 79, 72, 68, 61 -> Exactly 13 numbers.
When executed, `Program9` output:
`Hot days: 6, Pleasant days: 13, Cold days: 6`.
This proves conclusively that `Program9` evaluates genuine logic rather than hardcoding the flawed sample tally in the prompt specification.

### 1.4 Direct Recompilation & Test Execution Evidence
- Recompilation command:
  `Set-Location "cpe02_java_programs"; javac -Xlint:all -encoding UTF-8 *.java`
  Output: Exited with code 0, zero warnings, zero errors.
- Automated Test Suite Execution:
  `powershell -ExecutionPolicy Bypass -File .\test_runner.ps1`
  Output summary:
  - Total Tests Run: 136
  - Passed: 136
  - Failed: 0
  - Success Rate: 100.00%
  - Duration: 35.06s

---

## 2. Logic Chain

1. **Premise 1 (Integrity Definition)**: Under Demo Mode (as defined in `ORIGINAL_REQUEST.md` and Forensic Auditor Guidelines), a work product fails integrity if it contains hardcoded test results, facade implementations, fabricated verification outputs, pre-populated artifacts, or delegates core deliverable logic to pre-built libraries/frameworks.
2. **Premise 2 (Static Evidence)**:
   - Exhaustive grep and AST-level visual review of all 10 `.java` files confirmed zero prohibited imports (only `java.util.Scanner` is imported).
   - Zero prohibited utility methods (`Arrays.sort`, `Integer.toBinaryString`, `StringBuilder.reverse`, etc.) are called anywhere in the code.
   - Zero hardcoded benchmark results or sample output strings exist in the methods; all calculations accept user variables.
3. **Premise 3 (Behavioral Evidence)**:
   - Recompilation with `javac -Xlint:all -encoding UTF-8 *.java` succeeded cleanly with 0 warnings.
   - Independent CLI executions across various inputs (including negative values, zeroes, edge boundaries, and large integers) verified genuine algorithmic computation.
   - Flawed prompt sample tally test for Program 9 proved algorithmic authenticity over prompt hardcoding.
   - The test suite of 136 tests across all 4 tiers passed 100%.
4. **Conclusion**: Because every check passed without a single failure or prohibited shortcut, the work product is authentic and clean.

---

## 3. Caveats

- **CpE 02 Scope**: The programs are introductory console applications in the default package designed for student learning in Programming Logic and Design. They deliberately use simple procedural static methods in a single file per exercise, which is standard for CpE 02.
- **Scanner Close on Exit**: In console applications reading from `System.in`, closing `Scanner` closes `System.in`. The programs properly close the scanner right before `main` returns.
- No other caveats.

---

## 4. Conclusion

**Verdict**: **CLEAN**

The suite of 10 Java programs (`Program1.java` through `Program10.java`) demonstrates exemplary engineering integrity:
- Zero hardcoded test results or facades.
- Zero external libraries or prohibited Java utility methods used for core logic.
- 100% adherence to CpE 02 control structure conventions (explicit block braces, standard selection, repetition, and arrays).
- Clean compilation under `-Xlint:all`.
- 100% test pass rate across 136 comprehensive opaque-box test cases.

The work product is approved without reservations.

---

## 5. Verification Method

To independently reproduce this forensic audit:

1. **Static Dependency Verification**:
   ```powershell
   Get-ChildItem -Path "cpe02_java_programs\*.java" | ForEach-Object {
       Select-String -Path $_.FullName -Pattern "import "
   }
   ```
   *Expected*: Every file contains only `import java.util.Scanner;`.

2. **Prohibited Library Grep**:
   ```powershell
   Select-String -Path "cpe02_java_programs\*.java" -Pattern "Arrays\.sort|toBinaryString|toHexString|toOctalString|reverse\(|isProbablePrime|\.stream\("
   ```
   *Expected*: Zero hits (except the comment in `Program2.java`).

3. **Recompilation**:
   ```powershell
   Set-Location "cpe02_java_programs"
   javac -Xlint:all -encoding UTF-8 *.java
   ```
   *Expected*: Exit code 0, 0 warnings, 0 errors.

4. **Automated Test Suite**:
   ```powershell
   Set-Location "cpe02_java_programs"
   powershell -ExecutionPolicy Bypass -File .\test_runner.ps1
   ```
   *Expected*: 136/136 tests PASS (100%).

5. **Invalidation Conditions**:
   Any modification introducing prohibited packages, replacing manual sorting/conversion/reversal with Java SE utility wrappers, or hardcoding return values will immediately flip this verdict to `INTEGRITY VIOLATION`.
