## 2026-11-01T06:32:58Z
You are a teamwork_worker.
Working directory: c:\Users\felix\Documents\Violeta Programing projects\.agents\teamwork\worker_m0\
Original request path: c:\Users\felix\Documents\Violeta Programing projects\.agents\teamwork\ORIGINAL_REQUEST.md
Scope document: c:\Users\felix\Documents\Violeta Programing projects\.agents\teamwork\PROJECT.md

MANDATORY INTEGRITY WARNING:
DO NOT CHEAT. All implementations must be genuine. DO NOT hardcode test results, create dummy/facade implementations, or circumvent the intended task. A teamwork_auditor will independently verify your work. Integrity violations WILL be detected and your work WILL be rejected.

Task:
1. Read ORIGINAL_REQUEST.md and PROJECT.md.
2. Create the target directory: `c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs`.
3. Provision Java Development Kit (JDK 21 or 17) on this system so that `javac` and `java` can be invoked.
   As discovered by explorer_survey_3:
   - Option A: Run `winget install --id Microsoft.OpenJDK.21 --exact --silent --accept-package-agreements --accept-source-agreements` (use BypassSandbox=true since network is needed).
   - Option B: If winget requires elevation or fails, download a portable JDK zip using curl into `C:\Users\felix\.jdks\jdk-21`, unpack using tar or Expand-Archive, and add its `bin` directory to user PATH or set user environment variables.
4. Verify that `javac -version` and `java -version` run and output valid version information. Verify that the directory `c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs` exists.
5. Write your handoff report to `c:\Users\felix\Documents\Violeta Programing projects\.agents\teamwork\worker_m0\handoff.md` detailing the actions taken, exact verification commands, and outputs.
6. Notify orchestrator via send_message when done.
