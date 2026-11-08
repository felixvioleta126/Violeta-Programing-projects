# Detailed Environment & Workspace Analysis for CPE02 Java Programs

**Investigator**: `explorer_survey_3`  
**Date**: 2026-11-01  
**Target Workspace**: `c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs`  
**Parent Workspace**: `c:\Users\felix\Documents\Violeta Programing projects`  

---

## 1. Executive Summary

A comprehensive environment probe of the Windows host system and target workspace was conducted to assess readiness for implementing and testing the 10 standalone Java programs defined in `ORIGINAL_REQUEST.md`.

### Core Findings
1. **JDK Availability**: Neither `javac` nor `java` is installed or present in `PATH`. System registry and Chocolatey checks confirm that no JDK is currently installed.
2. **Installation Channels**:
   - `winget` (v1.29.380) is operational outside the sandbox and lists official packages such as `Microsoft.OpenJDK.21`, `Microsoft.OpenJDK.17`, and `EclipseAdoptium.Temurin.21.JDK`.
   - Windows native `curl.exe` (v8.21.0) and `tar.exe` (v3.8.9) are available, enabling direct non-elevated portable extraction of OpenJDK / Temurin binaries to a user-local directory (e.g. `C:\Users\felix\.jdks\jdk-21` or `.\tools\jdk-21`).
3. **Target Directory State**: `c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs` does **not** currently exist. The parent folder contains only `.agents` and `.git`. File system ACLs grant `FEL_PC\felix` `FullControl` with inheritance, permitting seamless directory creation.
4. **Compilation & Execution Strategy**: Standalone compilation via `javac -encoding UTF-8 *.java` in the target directory, producing default-package `.class` files, executed via `java -cp . Program<N>`.
5. **Interactive Testing Harness**: Piped stdin and `System.Diagnostics.Process` redirection were experimentally tested in PowerShell 5.1 and verified fully functional. A robust, automated test harness combining an external PowerShell test runner (`test_runner.ps1`) and an in-process Java test harness (`TestRunner.java`) is recommended to guarantee strict end-to-end verification without human input intervention.
6. **Encoding and Line Endings**: Source files must use UTF-8 without BOM. Compilation must explicitly declare `-encoding UTF-8`. Output assertions must handle both Windows CRLF (`\r\n`) and LF (`\n`) using regex line normalization (`\r?\n`).

---

## 2. Environment & Toolchain Survey

### 2.1 Compiler and Runtime Checks
A probe of commands in PowerShell yielded:
- `Get-Command javac, java`:
  - `CommandNotFoundException`: Neither `javac` nor `java` is recognized.
- Environment variables:
  - `JAVA_HOME`, `JDK_HOME`, and `JRE_HOME` are **not set** in Process, User, or Machine scopes.
- System & User PATH:
  - Total entries: 16 directories inspected (`C:\Windows\system32`, `C:\Program Files\Git\cmd`, `C:\Program Files\dotnet\`, `C:\ProgramData\chocolatey\bin`, etc.). None point to a Java installation.
- Common directory traversal:
  - `C:\Program Files\Java`: Not found.
  - `C:\Program Files (x86)\Java`: Not found.
  - `C:\Program Files\Eclipse Adoptium`: Not found.
  - `C:\Users\felix\.jdks`: Not found.
- Registry keys:
  - `HKLM:\SOFTWARE\JavaSoft`: Not found.
  - `HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall`: No entries containing Java/JDK/OpenJDK/JRE.

### 2.2 Available Package Managers and System Utilities
The host system possesses several package management and retrieval tools:
| Utility | Location | Version | Status & Capability |
|---|---|---|---|
| `winget.exe` | `C:\Users\felix\AppData\Local\Microsoft\WindowsApps\winget.exe` | `1.29.380` | Operational outside sandbox (`BypassSandbox: true`). Contains `Microsoft.OpenJDK.21` (v21.0.13.1021) and `EclipseAdoptium.Temurin.21.JDK` (v21.0.13.9). |
| `choco.exe` | `C:\ProgramData\chocolatey\bin\choco.exe` | `2.7.5` | Installed, but community repository access requires network permission outside sandbox. |
| `curl.exe` | `C:\Windows\System32\curl.exe` | `8.21.0` | Native Windows curl supporting HTTPS, redirects (`-L`), and SSL via Schannel. |
| `tar.exe` | `C:\Windows\System32\tar.exe` | `3.8.9` (bsdtar) | Capable of expanding `.zip` and `.tar.gz` archives directly on Windows. |

### 2.3 Recommended JDK Acquisition Strategies
Before implementation can compile or run code, a JDK must be installed or provisioned. Two viable strategies exist:

#### Strategy A: Portable JDK Archive (Zero Admin Elevation, Completely Self-Contained)
- **Mechanism**: Download the official Eclipse Adoptium Temurin 21 Windows x64 zip archive using `curl.exe`, unpack with `tar.exe` into a local directory (such as `C:\Users\felix\.jdks\jdk-21` or a workspace `.tools` folder), and configure environment variables in the PowerShell session.
- **Commands**:
  ```powershell
  $jdkDir = "C:\Users\felix\.jdks\jdk-21"
  New-Item -ItemType Directory -Path $jdkDir -Force | Out-Null
  $zipUrl = "https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.13+9/OpenJDK21U-jdk_x64_windows_hotspot_21.0.13_9.zip"
  curl.exe -L -o "$env:TEMP\temurin21.zip" $zipUrl
  tar.exe -xf "$env:TEMP\temurin21.zip" -C $jdkDir --strip-components=1
  Remove-Item "$env:TEMP\temurin21.zip"
  $env:JAVA_HOME = $jdkDir
  $env:PATH = "$jdkDir\bin;" + $env:PATH
  ```
- **Advantages**:
  - Requires **zero administrative rights** and **no UAC prompts**.
  - Does not pollute system-wide registries.
  - Can be deleted or relocated at will.

#### Strategy B: Automated Package Installation via Winget
- **Mechanism**: Run `winget install Microsoft.OpenJDK.21 --silent --accept-package-agreements --accept-source-agreements` with `BypassSandbox: true`.
- **Advantages**:
  - Automatically installs Microsoft Build of OpenJDK 21 LTS and registers PATH system-wide.

---

## 3. Target Workspace Survey

### 3.1 Directory Status
- Target directory: `c:\Users\felix\Documents\Violeta Programing projects\cpe02_java_programs`
- Status: **Does not exist yet** (`Test-Path` returned `False`).
- Parent directory: `c:\Users\felix\Documents\Violeta Programing projects` contains:
  - `.agents/` (teamwork metadata and task definitions)
  - `.git/` (git repository tracking)

### 3.2 Access Control & Permissions
- Target parent folder ACL check:
  - Owner: `FEL_PC\felix`
  - Access rule: `FEL_PC\felix Allow FullControl`
  - Inheritance: `(A;OICIID;FA;;;S-1-5-21-895898649-3397819107-1810633285-1001)` (Object Inherit, Container Inherit, Full Access).
- Permission verdict: Any subfolder created under this tree inherits `FullControl` without permission restrictions.

---

## 4. Compilation & Execution Architecture

### 4.1 Packaging Convention
Per `ORIGINAL_REQUEST.md` (lines 48–52):
- Each program must be a **standalone `.java` file with its own `main` method**.
- Programs are named `Program1.java` through `Program10.java`.
- Programs must use the **default package** (i.e., no `package com.example;` declaration at the top) so that introductory programming students and grading scripts can compile and run them directly with `javac Program1.java` and `java Program1`.

### 4.2 Standard Build Commands
In the target directory `cpe02_java_programs`:
1. **Compile All Programs**:
   ```powershell
   javac -encoding UTF-8 -d . *.java
   ```
2. **Compile Individual Program**:
   ```powershell
   javac -encoding UTF-8 Program1.java
   ```
3. **Clean Compiled Artifacts**:
   ```powershell
   Remove-Item -Path *.class -Force
   ```

### 4.3 Standard Execution Commands
From the directory containing the compiled `.class` files:
```powershell
java -cp . Program1
java -cp . Program2
...
java -cp . Program10
```

---

## 5. Automated Test Harness Architecture

### 5.1 The Verification Challenge
All 10 programs are interactive console applications designed for CpE 02 students. They instantiate `java.util.Scanner(System.in)`, issue console prompts (e.g., `Enter first number: `), and wait synchronously for user input.

To satisfy Acceptance Criterion 11 ("An automated test harness or script verifies all 10 programs against the test cases with all checks passing") without manual interaction, the test framework must:
1. Provide predefined input streams via standard input (`stdin`).
2. Capture the full standard output (`stdout`) and standard error (`stderr`).
3. Terminate cleanly within a reasonable timeout threshold (e.g., 5 seconds) to catch infinite loops or blocked `Scanner.next()` calls.
4. Extract calculated results from the output stream and verify them against expected values.

### 5.2 Test Runner Architecture Comparison

| Dimension | Option A: PowerShell Test Runner (`test_runner.ps1`) | Option B: Java In-Process Test Suite (`TestRunner.java`) |
|---|---|---|
| **Execution Environment** | Sub-process invocation via `System.Diagnostics.Process` in PowerShell | In-process JVM execution via `System.setIn` / `System.setOut` |
| **Fidelity to Real User** | Exact real-world CLI simulation (spawns `java.exe`, exercises OS process pipes) | Synthetic stream interception within JVM |
| **Isolation** | Perfect process-level isolation (crashes or `System.exit()` do not kill the runner) | Requires guarding against `System.exit()`; thread safety considerations |
| **Timeout Handling** | Native `Process.WaitForExit(int milliseconds)` kills hung processes reliably | Requires separate thread management or timeout wrappers |
| **Speed** | Moderate (~100–300ms per program launch) | Fast (<50ms for all 10 programs combined) |
| **Method-level Testing** | Tests CLI stdout only | Can test both CLI stdout AND pure helper methods (`createArithmeticSeq()`, `isPalindrome()`, etc.) |

### 5.3 Recommended Solution: Complementary Dual Harness

The recommended architecture deploys **both** harnesses:
1. **Primary CLI Acceptance Runner (`test_runner.ps1`)**: Verifies the exact process behavior as a user or grading script would run it.
2. **Supplemental Java Unit Harness (`TestAll.java`)**: Verifies internal method signatures, array allocations, and edge cases directly in Java.

#### Specification for `test_runner.ps1`:
```powershell
# Synopsis of test_runner.ps1 architecture
param (
    [string]$JavaBin = "java"
)

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$script:passed = 0
$script:failed = 0

function Invoke-JavaTest {
    param (
        [string]$ClassName,
        [string]$InputText,
        [scriptblock]$Validator,
        [string]$TestDescription,
        [int]$TimeoutMs = 5000
    )

    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = $JavaBin
    $psi.Arguments = "-cp . $ClassName"
    $psi.RedirectStandardInput = $true
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true
    $psi.UseShellExecute = $false
    $psi.CreateNoWindow = $true

    $proc = [System.Diagnostics.Process]::Start($psi)
    if (-not [string]::IsNullOrEmpty($InputText)) {
        $proc.StandardInput.Write($InputText)
    }
    $proc.StandardInput.Close()

    if (-not $proc.WaitForExit($TimeoutMs)) {
        $proc.Kill()
        Write-Host "[-] $TestDescription : TIMEOUT ($TimeoutMs ms)" -ForegroundColor Red
        $script:failed++
        return
    }

    $stdout = $proc.StandardOutput.ReadToEnd()
    $stderr = $proc.StandardError.ReadToEnd()

    $passed = $false
    try {
        $passed = & $Validator $stdout $stderr $proc.ExitCode
    } catch {
        $passed = $false
    }

    if ($passed) {
        Write-Host "[+] $TestDescription : PASS" -ForegroundColor Green
        $script:passed++
    } else {
        Write-Host "[-] $TestDescription : FAIL" -ForegroundColor Red
        Write-Host "    STDOUT: $stdout" -ForegroundColor Yellow
        if ($stderr) { Write-Host "    STDERR: $stderr" -ForegroundColor DarkRed }
        $script:failed++
    }
}
```

#### Specification for `TestAll.java`:
```java
// Synopsis of in-process test architecture
import java.io.*;
import java.nio.charset.StandardCharsets;

public class TestAll {
    private static int passed = 0;
    private static int failed = 0;

    private static String runMainWithInput(Runnable mainCall, String input) {
        InputStream origIn = System.in;
        PrintStream origOut = System.out;
        try {
            System.setIn(new ByteArrayInputStream(input.getBytes(StandardCharsets.UTF_8)));
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            System.setOut(new PrintStream(out, true, StandardCharsets.UTF_8));
            mainCall.run();
            return out.toString(StandardCharsets.UTF_8);
        } finally {
            System.setIn(origIn);
            System.setOut(origOut);
        }
    }

    public static void main(String[] args) {
        testProgram1();
        testProgram2();
        // ... through Program10
        System.out.printf("Results: %d passed, %d failed%n", passed, failed);
        if (failed > 0) System.exit(1);
    }
    // Individual program test methods...
}
```

---

## 6. Synthesized Test Matrix for Programs 1 to 10

Based on `ORIGINAL_REQUEST.md`, `explorer_survey_1`, and `explorer_survey_2`, the following test matrix specifies input feeds, expected output patterns, and validation rules for the automated test harness:

| Program | Name | Sample Stdin Feed | Expected Output Markers | Edge Cases to Test |
|---|---|---|---|---|
| **Program 1** | Arithmetic Sequence | `21` `5` | `21 26 31 36 41 46 51 56 61 66 71 76 81 86 91 96` (16 terms) | Negative `diff` (e.g. `100 -5`), zero diff (`7 0`) |
| **Program 2** | Min/Max & Sorting | `42 17 88 5 23` | Min: `5`, Max: `88`<br>Ascending: `5 17 23 42 88`<br>Descending: `88 42 23 17 5` | Negative numbers (`-10 0 5 -3 2`), identical numbers (`4 4 4 4 4`) |
| **Program 3** | Number System Converter | Case A: `14` `1`<br>Case B: `14` `2`<br>Case C: `14` `3` | Case A: `1110`<br>Case B: `16`<br>Case C: `E` | Input `0` -> `0`, Hexadecimal values requiring A–F lookup (`255 3` -> `FF`) |
| **Program 4** | Triangle Classification | Case A: `5 5 5`<br>Case B: `5 5 3`<br>Case C: `3 4 5`<br>Case D: `1 2 10` | Case A: `Equilateral`<br>Case B: `Isosceles`<br>Case C: `Scalene`<br>Case D: `Invalid` (fails inequality) | Triangle inequality violation (`0 0 0`, `1 2 3`, negative sides) |
| **Program 5** | Palindrome Checker | Case A: `121`<br>Case B: `321`<br>Case C: `1221`<br>Case D: `-121` | Case A: `Palindrome`<br>Case B: `Not palindrome` (or composite equivalent)<br>Case C: `Palindrome`<br>Case D: `Not palindrome` | Single digit (`7` -> Palindrome), multi-digit symmetric numbers |
| **Program 6** | Day of Year | Case A: `1 1 1994`<br>Case B: `12 31 1993`<br>Case C: `12 31 1996`<br>Case D: `3 1 2000`<br>Case E: `3 1 1900` | Case A: `1`<br>Case B: `365`<br>Case C: `366`<br>Case D: `61` (leap year: Feb 29 days)<br>Case E: `60` (non-leap century) | Leap century (2000) vs non-leap century (1900, 2100); Feb 29 in leap year |
| **Program 7** | Prime or Composite | Case A: `2`<br>Case B: `13`<br>Case C: `4`<br>Case D: `15`<br>Case E: `1` | Case A: `Prime`<br>Case B: `Prime`<br>Case C: `Composite`<br>Case D: `Composite`<br>Case E: Neither prime nor composite | Small numbers ($n \le 1$: not prime/composite), large primes (e.g. 97) |
| **Program 8** | Greatest Common Divisor | Case A: `54 24`<br>Case B: `17 19`<br>Case C: `0 48` | Case A: `6`<br>Case B: `1`<br>Case C: `48` | Coprime numbers, one zero parameter, negative numbers (GCD always $\ge 1$) |
| **Program 9** | Daily Temperatures | Sequence of 25 values:<br>`55 62 68 74 59 45 41 58 60 67 65 78 82 88 91 92 90 93 87 78 79 72 68 61 59` (terminated by EOF or sentinel `-999`) | Hot ($\ge 85$): `6`<br>Pleasant ($60 \dots 84$): `13`<br>Cold ($< 60$): `6`<br>Each reading displayed with category | Exact boundary temperatures: 85 (Hot), 84 (Pleasant), 60 (Pleasant), 59 (Cold) |
| **Program 10** | Exam Scores Sentinel | `98 87 86 85 85 78 73 72 72 72 70 66 63 50 -1` | Total: `14`<br>A: `1`<br>B: `4`<br>C: `6`<br>D: `2`<br>F: `1` | Immediate termination (`-1` -> Total 0), boundary grades: 90 (A), 89 (B), 80 (B), 79 (C), 70 (C), 69 (D), 60 (D), 59 (F) |

---

## 7. File Encoding, Line Endings, and System Permissions

### 7.1 Encoding Standard
- **Encoding**: UTF-8 without Byte Order Mark (BOM).
- **Source compilation command**: `javac -encoding UTF-8 ...`. Declaring `-encoding UTF-8` avoids Windows code page defaults (CP1252 / OEM 437) from corrupting comments, strings, or special symbols.
- **PowerShell Session Configuration**:
  ```powershell
  [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
  $OutputEncoding = [System.Text.Encoding]::UTF8
  ```

### 7.2 Line Ending Resilience
- Windows uses CRLF (`\r\n`), while Git / Linux uses LF (`\n`).
- In Java, `Scanner.nextInt()`, `Scanner.nextDouble()`, and `Scanner.next()` delimit tokens using standard whitespace regex `\s+`, which treats `\r` and `\n` identically.
- When matching multi-line output in test scripts, test regexes should use `\r?\n` rather than hardcoded `\r\n` or `\n`.

### 7.3 Permissions and Sandbox Constraints
- PowerShell Execution Policy: `RemoteSigned` for Process scope. Scripts within the workspace run without policy blocks.
- Sandbox Behavior:
  - Commands run with `BypassSandbox: false` are isolated from outbound internet and cannot resolve DNS for external endpoints.
  - Commands requiring network access (such as `winget` or `curl` to download JDK) must use `BypassSandbox: true`.
- Local Disk Permissions:
  - The working directory tree `c:\Users\felix\Documents\Violeta Programing projects` allows full read, write, and execute for `felix`.

---

## 8. Recommendations for Next Phases

1. **Workspace Setup (Phase 1)**:
   - Provide JDK (via winget or portable Temurin zip) and ensure `java` and `javac` are present in PATH.
   - Create `cpe02_java_programs` directory.
   - Lay out `PROJECT.md` incorporating the findings of all 3 survey explorers.
2. **Implementation (Phase 2)**:
   - Implement `Program1.java` through `Program10.java` following CpE 02 guidelines (no pre-built sorting or conversion libraries, clean loops, standard arrays, standalone classes with `main`).
3. **Automated Testing (Phase 3)**:
   - Implement `test_runner.ps1` in `cpe02_java_programs` implementing the multi-program test harness defined in Section 5.3.
   - Run complete end-to-end verification and capture results in the test log.
