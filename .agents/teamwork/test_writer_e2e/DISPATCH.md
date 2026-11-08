## 2026-11-01T06:42:33Z

You are a teamwork_test_writer.
Working directory: c:\Users\felix\Documents\Violeta Programing projects\.agents\teamwork\test_writer_e2e\
Original request path: c:\Users\felix\Documents\Violeta Programing projects\.agents\teamwork\ORIGINAL_REQUEST.md
Scope document: c:\Users\felix\Documents\Violeta Programing projects\.agents\teamwork\PROJECT.md
Test Infra document: c:\Users\felix\Documents\Violeta Programing projects\.agents\teamwork\TEST_INFRA.md
Explorer findings path: c:\Users\felix\Documents\Violeta Programing projects\.agents\teamwork\explorer_survey_3\analysis.md

MANDATORY INTEGRITY WARNING:
DO NOT CHEAT. All implementations must be genuine. DO NOT hardcode test results, create dummy/facade implementations, or circumvent the intended task. A teamwork_auditor will independently verify your work. Integrity violations WILL be detected and your work WILL be rejected.

File Ownership:
You have exclusive write ownership of:
- c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs\test_runner.ps1
- c:\Users\felix\Documents\Violeta Programing projects\.agents\teamwork\TEST_READY.md
You MUST NOT modify or touch any .java files!

Requirements:
Read ORIGINAL_REQUEST.md, PROJECT.md, and TEST_INFRA.md.
Design and create a comprehensive automated opaque-box test runner in PowerShell: `cpe02_java_programs\test_runner.ps1`.
It must test all 10 programs (`Program1` through `Program10`) across:
- Tier 1: Feature Coverage (>=5 test cases per program)
- Tier 2: Boundary & Corner Cases (>=5 test cases per program: empty/zero/negative values, boundaries)
- Tier 3: Cross-Feature / Parameter variation combinations
- Tier 4: Real-World Scenarios (multi-step realistic data sets)
Total test cases should be >= 110 automated tests.
Each test runs `java -cp . Program<N>` by redirecting StandardInput with predefined input text and capturing StandardOutput with a timeout (e.g. 5 seconds) to prevent infinite hangs.
Verify that output matches expected substrings or patterns.
Report detailed test results (Test ID, Program, Tier, Description, Result: PASS/FAIL).
When all tests pass, exit code is 0; if any test fails, exit code is non-zero.
When finished creating and validating `test_runner.ps1`, publish `c:\Users\felix\Documents\Violeta Programing projects\.agents\teamwork\TEST_READY.md` following the template in PROJECT.md.
Write your handoff report to `c:\Users\felix\Documents\Violeta Programing projects\.agents\teamwork\test_writer_e2e\handoff.md` and notify orchestrator via send_message when done.
