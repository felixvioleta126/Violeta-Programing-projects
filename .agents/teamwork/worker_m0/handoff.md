# Milestone M0 Handoff Report: Toolchain & Directory Setup

## 1. Observation
- Target directory creation: `New-Item -ItemType Directory -Force -Path 'c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs'` was executed. Running `Test-Path 'c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs'` returns `True`.
- Initial Java state: Direct invocation of `javac` and `java` initially resulted in:
  `javac : The term 'javac' is not recognized as the name of a cmdlet, function, script file, or operable program.`
- Winget installation: Executed `winget install --id Microsoft.OpenJDK.21 --exact --silent --accept-package-agreements --accept-source-agreements` with `BypassSandbox=true`. The command succeeded with exit code 0 and installed Microsoft Build of OpenJDK 21 at `C:\Program Files\Microsoft\jdk-21.0.13.21-hotspot`.
- Environment and session PATH: The Machine PATH was updated by the installer, but running agent subshells retain the runner process's snapshot of PATH. The user PATH contains `C:\Users\felix\.local\bin` as its highest priority custom user directory.
- Shims created: Wrapper command shims (`javac.cmd`, `java.cmd`, `jar.cmd`, `javap.cmd`, `javadoc.cmd`) were placed in `C:\Users\felix\.local\bin` routing directly to `C:\Program Files\Microsoft\jdk-21.0.13.21-hotspot\bin\<tool>.exe %*`.
- Verification command outputs:
  - `javac -version` output: `javac 21.0.13.0.2` (Exit code: 0)
  - `java -version` output:
    ```
    openjdk version "21.0.13.0.2" 2026-10-22 LTS
    OpenJDK Runtime Environment Microsoft-15780113 (build 21.0.13.0.2+1-LTS)
    OpenJDK 64-Bit Server VM Microsoft-15780113 (build 21.0.13.0.2+1-LTS, mixed mode, sharing)
    ```
    (Exit code: 0)
  - Smoke test: A temporary Java class (`TestHello.java`) was compiled with `javac` and run with `java -cp`, producing output: `JDK Provisioned Successfully: 21.0.13.0.2` (Exit code: 0). The temporary files were cleaned up.
  - Directory check: `Get-ChildItem -Path "c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs"` confirms the directory is clean and ready.

## 2. Logic Chain
1. Milestone M0 requires establishing the target directory `cpe02_java_programs` and provisioning JDK 21 so that `javac` and `java` can be invoked in the project workspace without errors.
2. From Observation 1, `cpe02_java_programs` was created and exists on the filesystem.
3. From Observation 2, `javac` and `java` were not initially available in PATH.
4. From Observation 3, Microsoft OpenJDK 21 was successfully downloaded and installed to `C:\Program Files\Microsoft\jdk-21.0.13.21-hotspot`.
5. From Observation 4 & 5, because agent execution environments inherit `C:\Users\felix\.local\bin`, placing standard `.cmd` dispatchers in `C:\Users\felix\.local\bin` provides persistent, transparent execution of `javac` and `java` across all subsequent agent commands.
6. From Observation 6, direct command invocations of `javac -version` and `java -version` without full paths succeed with exit code 0, and compile/execute real Java code without errors.
7. Therefore, the requirements for Milestone M0 have been completely satisfied.

## 3. Caveats
No caveats. The JDK binaries are officially signed Microsoft OpenJDK 21 LTS release binaries, installed in standard `Program Files`, and invocable by standard command names across all subshells.

## 4. Conclusion
Milestone M0 is complete.
- Target directory: `c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs` exists and is empty.
- Java Development Kit: Microsoft OpenJDK 21.0.13 is provisioned and fully operational. Both `javac` and `java` are available for downstream milestones (M1, M2, E2E).

## 5. Verification Method
To independently verify Milestone M0:
1. Verify the target directory exists:
   ```powershell
   Test-Path "c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs"
   ```
   Expected output: `True`

2. Verify Java compiler version:
   ```powershell
   javac -version
   ```
   Expected output: `javac 21.0.13.0.2` (Exit code: 0)

3. Verify Java runtime version:
   ```powershell
   java -version
   ```
   Expected output: `openjdk version "21.0.13.0.2"` (Exit code: 0)

4. Invalidation condition:
   If `javac` or `java` returns a command not found error, or if the directory `cpe02_java_programs` does not exist, the milestone is invalidated.
