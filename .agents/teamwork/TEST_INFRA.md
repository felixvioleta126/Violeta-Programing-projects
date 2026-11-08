# E2E Test Infra: CpE 02 Programming Logic and Design

## Test Philosophy
- Opaque-box, requirement-driven: Validates external behavior via CLI standard input/output redirection.
- Non-interactive automated execution: Automated test script (`test_runner.ps1`) drives `java Program<N>` by feeding prepared input text to stdin and evaluating stdout against expected patterns.
- Multi-tier coverage: Category-Partition (Tier 1), Boundary Value Analysis (Tier 2), Cross-Feature Combinations (Tier 3), Real-World Scenarios (Tier 4), Adversarial Stress Tests (Tier 5).

## Feature Inventory
| # | Feature | Source | Tier 1 | Tier 2 | Tier 3 |
|---|---------|--------|:------:|:------:|:------:|
| 1 | Program 1: Arithmetic Sequence | ORIGINAL_REQUEST §R1 | >=5 | >=5 | ✓ |
| 2 | Program 2: Min/Max & 5-Number Sorting | ORIGINAL_REQUEST §R2 | >=5 | >=5 | ✓ |
| 3 | Program 3: Number System Converter | ORIGINAL_REQUEST §R3 | >=5 | >=5 | ✓ |
| 4 | Program 4: Triangle Classification | ORIGINAL_REQUEST §R4 | >=5 | >=5 | ✓ |
| 5 | Program 5: Palindrome Number Checker | ORIGINAL_REQUEST §R5 | >=5 | >=5 | ✓ |
| 6 | Program 6: Day of Year Calculation | ORIGINAL_REQUEST §R6 | >=5 | >=5 | ✓ |
| 7 | Program 7: Prime or Composite Checker | ORIGINAL_REQUEST §R7 | >=5 | >=5 | ✓ |
| 8 | Program 8: Greatest Common Divisor | ORIGINAL_REQUEST §R8 | >=5 | >=5 | ✓ |
| 9 | Program 9: Daily Temperatures Analysis | ORIGINAL_REQUEST §R9 | >=5 | >=5 | ✓ |
| 10 | Program 10: Exam Scores & Grade Distribution | ORIGINAL_REQUEST §R10 | >=5 | >=5 | ✓ |

## Test Architecture
- Location of tests: `c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs\test_runner.ps1`
- Invocation: `powershell -ExecutionPolicy Bypass -File test_runner.ps1`
- Pass/Fail semantics: Exit code 0 indicates 100% pass across all test cases; non-zero indicates failure. Detailed per-test reporting printed to stdout.
- Timeout guard: 5-second execution timeout per test process to prevent stalls on unexpected input requests.

## Real-World Application Scenarios (Tier 4)
| # | Scenario | Features Exercised | Complexity |
|---|----------|--------------------|------------|
| 1 | Standard Classroom Benchmark | Programs 1, 2, 4, 10 with verified prompt values | Medium |
| 2 | Calendar and Astronomical Dating | Program 6 with leap centuries (1600, 2000, 2400) and non-leap centuries (1700, 1800, 1900, 2100) | Medium |
| 3 | Cryptographic Math Primes & GCD | Programs 7 and 8 with large coprime pairs, Carmichael-like composites, and common divisors | High |
| 4 | Meteorological Station Multi-Day Series | Program 9 with the 25-day sequence plus seasonal extremes | Medium |
| 5 | Computer Architecture Base Converter | Program 3 across full 16-bit boundaries (0, 255, 1024, 65535) | Medium |

## Coverage Thresholds
- Tier 1: >= 5 tests per feature (happy-path equivalence classes)
- Tier 2: >= 5 tests per feature (boundary and corner cases: zero, negatives, single digits, large values)
- Tier 3: Cross-feature tests (pairwise coverage of number systems, triangle types, prime vs GCD)
- Tier 4: >= 5 realistic application-level scenarios
- Total test cases: >= 110 automated tests in `test_runner.ps1`
