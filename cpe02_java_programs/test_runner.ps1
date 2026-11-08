<#
.SYNOPSIS
    CpE 02 Programming Logic and Design Comprehensive Automated Test Runner
.DESCRIPTION
    Automated opaque-box test runner executing Program1 through Program10
    across Tier 1 (Feature Coverage), Tier 2 (Boundary & Corner Cases),
    Tier 3 (Cross-Feature & Parameter Variations), and Tier 4 (Real-World Scenarios).
    Redirects StandardInput with predefined test vectors and captures StandardOutput
    with timeout enforcement.
#>

param (
    [string]$JavaBin = "",
    [int]$TimeoutMs = 5000,
    [string]$FilterProgram = ""
)

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if ([string]::IsNullOrEmpty($ScriptDir)) {
    $ScriptDir = (Get-Location).Path
}

# Resolve Java executable
if ([string]::IsNullOrEmpty($JavaBin)) {
    if (Get-Command "java.exe" -ErrorAction SilentlyContinue) {
        $JavaBin = (Get-Command "java.exe").Source
    } elseif ($env:JAVA_HOME -and (Test-Path "$env:JAVA_HOME\bin\java.exe")) {
        $JavaBin = "$env:JAVA_HOME\bin\java.exe"
    } elseif (Test-Path "C:\Program Files\Microsoft\jdk-21.0.13.21-hotspot\bin\java.exe") {
        $JavaBin = "C:\Program Files\Microsoft\jdk-21.0.13.21-hotspot\bin\java.exe"
    } else {
        $JavaBin = "java"
    }
}

Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host " CpE 02 Programming Logic & Design - Comprehensive Opaque-Box Test Runner" -ForegroundColor Cyan
Write-Host " Runtime: $JavaBin" -ForegroundColor Gray
Write-Host " Working Directory: $ScriptDir" -ForegroundColor Gray
Write-Host " Timeout per Test: $TimeoutMs ms" -ForegroundColor Gray
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host ""

# Define the comprehensive test suite (136 tests across Program1 to Program10)
$testSuite = @(
    # ==========================================================================
    # PROGRAM 1: Arithmetic Sequence (createArithmeticSeq)
    # ==========================================================================
    # Tier 1: Feature Coverage
    [PSCustomObject]@{
        Id = "TC001"; Program = "Program1"; Tier = "Tier 1"
        Description = "Standard arithmetic progression (first=21, diff=5)"
        Input = "21`n5`n"
        Expected = @("21 26 31 36 41 46 51 56 61 66 71 76 81 86 91 96")
    },
    [PSCustomObject]@{
        Id = "TC002"; Program = "Program1"; Tier = "Tier 1"
        Description = "Unit step progression (first=1, diff=1)"
        Input = "1`n1`n"
        Expected = @("1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16")
    },
    [PSCustomObject]@{
        Id = "TC003"; Program = "Program1"; Tier = "Tier 1"
        Description = "Multiples of 10 progression (first=10, diff=10)"
        Input = "10`n10`n"
        Expected = @("10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160")
    },
    [PSCustomObject]@{
        Id = "TC004"; Program = "Program1"; Tier = "Tier 1"
        Description = "Odd numbers progression step 2 (first=1, diff=2)"
        Input = "1`n2`n"
        Expected = @("1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31")
    },
    [PSCustomObject]@{
        Id = "TC005"; Program = "Program1"; Tier = "Tier 1"
        Description = "Step 7 progression (first=5, diff=7)"
        Input = "5`n7`n"
        Expected = @("5 12 19 26 33 40 47 54 61 68 75 82 89 96 103 110")
    },
    # Tier 2: Boundary & Corner Cases
    [PSCustomObject]@{
        Id = "TC006"; Program = "Program1"; Tier = "Tier 2"
        Description = "Zero common difference (first=7, diff=0)"
        Input = "7`n0`n"
        Expected = @("7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7")
    },
    [PSCustomObject]@{
        Id = "TC007"; Program = "Program1"; Tier = "Tier 2"
        Description = "Zero starting term (first=0, diff=4)"
        Input = "0`n4`n"
        Expected = @("0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60")
    },
    [PSCustomObject]@{
        Id = "TC008"; Program = "Program1"; Tier = "Tier 2"
        Description = "Negative common difference (first=50, diff=-5)"
        Input = "50`n-5`n"
        Expected = @("50 45 40 35 30 25 20 15 10 5 0 -5 -10 -15 -20 -25")
    },
    [PSCustomObject]@{
        Id = "TC009"; Program = "Program1"; Tier = "Tier 2"
        Description = "Negative starting term crossing zero (first=-30, diff=4)"
        Input = "-30`n4`n"
        Expected = @("-30 -26 -22 -18 -14 -10 -6 -2 2 6 10 14 18 22 26 30")
    },
    [PSCustomObject]@{
        Id = "TC010"; Program = "Program1"; Tier = "Tier 2"
        Description = "Both negative first and negative diff (first=-5, diff=-5)"
        Input = "-5`n-5`n"
        Expected = @("-5 -10 -15 -20 -25 -30 -35 -40 -45 -50 -55 -60 -65 -70 -75 -80")
    },
    # Tier 3: Parameter Variations
    [PSCustomObject]@{
        Id = "TC011"; Program = "Program1"; Tier = "Tier 3"
        Description = "Large integer progression (first=1000, diff=250)"
        Input = "1000`n250`n"
        Expected = @("1000 1250 1500 1750 2000 2250 2500 2750 3000 3250 3500 3750 4000 4250 4500 4750")
    },
    [PSCustomObject]@{
        Id = "TC012"; Program = "Program1"; Tier = "Tier 3"
        Description = "Symmetric sequence crossing origin (first=-15, diff=2)"
        Input = "-15`n2`n"
        Expected = @("-15 -13 -11 -9 -7 -5 -3 -1 1 3 5 7 9 11 13 15")
    },
    # Tier 4: Real-World Scenarios
    [PSCustomObject]@{
        Id = "TC013"; Program = "Program1"; Tier = "Tier 4"
        Description = "Physics deceleration countdown progression (first=100, diff=-10)"
        Input = "100`n-10`n"
        Expected = @("100 90 80 70 60 50 40 30 20 10 0 -10 -20 -30 -40 -50")
    },

    # ==========================================================================
    # PROGRAM 2: Min/Max and Sorting of 5 Numbers
    # ==========================================================================
    # Tier 1: Feature Coverage
    [PSCustomObject]@{
        Id = "TC014"; Program = "Program2"; Tier = "Tier 1"
        Description = "Standard 5 distinct positive numbers"
        Input = "42 17 88 5 23`n"
        Expected = @("Lowest (Min) number: 5", "Highest (Max) number: 88", "Ascending order: 5 17 23 42 88", "Descending order: 88 42 23 17 5")
    },
    [PSCustomObject]@{
        Id = "TC015"; Program = "Program2"; Tier = "Tier 1"
        Description = "Already sorted ascending list (1 2 3 4 5)"
        Input = "1 2 3 4 5`n"
        Expected = @("Lowest (Min) number: 1", "Highest (Max) number: 5", "Ascending order: 1 2 3 4 5", "Descending order: 5 4 3 2 1")
    },
    [PSCustomObject]@{
        Id = "TC016"; Program = "Program2"; Tier = "Tier 1"
        Description = "Already sorted descending list (50 40 30 20 10)"
        Input = "50 40 30 20 10`n"
        Expected = @("Lowest (Min) number: 10", "Highest (Max) number: 50", "Ascending order: 10 20 30 40 50", "Descending order: 50 40 30 20 10")
    },
    [PSCustomObject]@{
        Id = "TC017"; Program = "Program2"; Tier = "Tier 1"
        Description = "Single-digit scrambled numbers (9 1 7 3 5)"
        Input = "9 1 7 3 5`n"
        Expected = @("Lowest (Min) number: 1", "Highest (Max) number: 9", "Ascending order: 1 3 5 7 9", "Descending order: 9 7 5 3 1")
    },
    [PSCustomObject]@{
        Id = "TC018"; Program = "Program2"; Tier = "Tier 1"
        Description = "Multiples of hundred (300 100 500 200 400)"
        Input = "300 100 500 200 400`n"
        Expected = @("Lowest (Min) number: 100", "Highest (Max) number: 500", "Ascending order: 100 200 300 400 500", "Descending order: 500 400 300 200 100")
    },
    # Tier 2: Boundary & Corner Cases
    [PSCustomObject]@{
        Id = "TC019"; Program = "Program2"; Tier = "Tier 2"
        Description = "All negative integers (-10 -50 -2 -15 -8)"
        Input = "-10 -50 -2 -15 -8`n"
        Expected = @("Lowest (Min) number: -50", "Highest (Max) number: -2", "Ascending order: -50 -15 -10 -8 -2", "Descending order: -2 -8 -10 -15 -50")
    },
    [PSCustomObject]@{
        Id = "TC020"; Program = "Program2"; Tier = "Tier 2"
        Description = "All 5 numbers identical (7 7 7 7 7)"
        Input = "7 7 7 7 7`n"
        Expected = @("Lowest (Min) number: 7", "Highest (Max) number: 7", "Ascending order: 7 7 7 7 7", "Descending order: 7 7 7 7 7")
    },
    [PSCustomObject]@{
        Id = "TC021"; Program = "Program2"; Tier = "Tier 2"
        Description = "Mixed signs including zero (-5 12 0 -15 8)"
        Input = "-5 12 0 -15 8`n"
        Expected = @("Lowest (Min) number: -15", "Highest (Max) number: 12", "Ascending order: -15 -5 0 8 12", "Descending order: 12 8 0 -5 -15")
    },
    [PSCustomObject]@{
        Id = "TC022"; Program = "Program2"; Tier = "Tier 2"
        Description = "Multiple duplicate values (12 5 12 3 5)"
        Input = "12 5 12 3 5`n"
        Expected = @("Lowest (Min) number: 3", "Highest (Max) number: 12", "Ascending order: 3 5 5 12 12", "Descending order: 12 12 5 5 3")
    },
    [PSCustomObject]@{
        Id = "TC023"; Program = "Program2"; Tier = "Tier 2"
        Description = "Extreme symmetric boundaries with zeroes (-999 0 999 0 -999)"
        Input = "-999 0 999 0 -999`n"
        Expected = @("Lowest (Min) number: -999", "Highest (Max) number: 999", "Ascending order: -999 -999 0 0 999", "Descending order: 999 0 0 -999 -999")
    },
    # Tier 3: Parameter Variations
    [PSCustomObject]@{
        Id = "TC024"; Program = "Program2"; Tier = "Tier 3"
        Description = "Ten-thousands range integers"
        Input = "10000 50000 20000 40000 30000`n"
        Expected = @("Lowest (Min) number: 10000", "Highest (Max) number: 50000", "Ascending order: 10000 20000 30000 40000 50000", "Descending order: 50000 40000 30000 20000 10000")
    },
    [PSCustomObject]@{
        Id = "TC025"; Program = "Program2"; Tier = "Tier 3"
        Description = "Tight origin alternating values (-2 2 -1 1 0)"
        Input = "-2 2 -1 1 0`n"
        Expected = @("Lowest (Min) number: -2", "Highest (Max) number: 2", "Ascending order: -2 -1 0 1 2", "Descending order: 2 1 0 -1 -2")
    },
    # Tier 4: Real-World Scenarios
    [PSCustomObject]@{
        Id = "TC026"; Program = "Program2"; Tier = "Tier 4"
        Description = "Academic exam score ranking scenario (88 95 72 64 88)"
        Input = "88 95 72 64 88`n"
        Expected = @("Lowest (Min) number: 64", "Highest (Max) number: 95", "Ascending order: 64 72 88 88 95", "Descending order: 95 88 88 72 64")
    },

    # ==========================================================================
    # PROGRAM 3: Number System Converter Using Arrays
    # ==========================================================================
    # Tier 1: Feature Coverage
    [PSCustomObject]@{
        Id = "TC027"; Program = "Program3"; Tier = "Tier 1"
        Description = "Decimal 14 to Binary conversion"
        Input = "14`n1`n"
        Expected = @("Binary: 1110")
    },
    [PSCustomObject]@{
        Id = "TC028"; Program = "Program3"; Tier = "Tier 1"
        Description = "Decimal 14 to Octal conversion"
        Input = "14`n2`n"
        Expected = @("Octal: 16")
    },
    [PSCustomObject]@{
        Id = "TC029"; Program = "Program3"; Tier = "Tier 1"
        Description = "Decimal 14 to Hexadecimal conversion"
        Input = "14`n3`n"
        Expected = @("Hexadecimal: E")
    },
    [PSCustomObject]@{
        Id = "TC030"; Program = "Program3"; Tier = "Tier 1"
        Description = "Decimal 42 to Binary conversion"
        Input = "42`n1`n"
        Expected = @("Binary: 101010")
    },
    [PSCustomObject]@{
        Id = "TC031"; Program = "Program3"; Tier = "Tier 1"
        Description = "Decimal 100 to Octal conversion"
        Input = "100`n2`n"
        Expected = @("Octal: 144")
    },
    # Tier 2: Boundary & Corner Cases
    [PSCustomObject]@{
        Id = "TC032"; Program = "Program3"; Tier = "Tier 2"
        Description = "Decimal 0 to Binary conversion"
        Input = "0`n1`n"
        Expected = @("Binary: 0")
    },
    [PSCustomObject]@{
        Id = "TC033"; Program = "Program3"; Tier = "Tier 2"
        Description = "Decimal 0 to Octal conversion"
        Input = "0`n2`n"
        Expected = @("Octal: 0")
    },
    [PSCustomObject]@{
        Id = "TC034"; Program = "Program3"; Tier = "Tier 2"
        Description = "Decimal 0 to Hexadecimal conversion"
        Input = "0`n3`n"
        Expected = @("Hexadecimal: 0")
    },
    [PSCustomObject]@{
        Id = "TC035"; Program = "Program3"; Tier = "Tier 2"
        Description = "8-bit max (255) to Hexadecimal conversion"
        Input = "255`n3`n"
        Expected = @("Hexadecimal: FF")
    },
    [PSCustomObject]@{
        Id = "TC036"; Program = "Program3"; Tier = "Tier 2"
        Description = "Negative decimal input error rejection"
        Input = "-10`n1`n"
        Expected = @("Value must be positive")
    },
    # Tier 3: Parameter Variations
    [PSCustomObject]@{
        Id = "TC037"; Program = "Program3"; Tier = "Tier 3"
        Description = "Invalid menu choice option rejection"
        Input = "20`n5`n"
        Expected = @("Invalid choice")
    },
    [PSCustomObject]@{
        Id = "TC038"; Program = "Program3"; Tier = "Tier 3"
        Description = "8-bit all ones (255) to Binary conversion"
        Input = "255`n1`n"
        Expected = @("Binary: 11111111")
    },
    # Tier 4: Real-World Scenarios
    [PSCustomObject]@{
        Id = "TC039"; Program = "Program3"; Tier = "Tier 4"
        Description = "Computer architecture 1K boundary (1024 to Binary)"
        Input = "1024`n1`n"
        Expected = @("Binary: 10000000000")
    },
    [PSCustomObject]@{
        Id = "TC040"; Program = "Program3"; Tier = "Tier 4"
        Description = "16-bit word max boundary (65535 to Hexadecimal)"
        Input = "65535`n3`n"
        Expected = @("Hexadecimal: FFFF")
    },

    # ==========================================================================
    # PROGRAM 4: Triangle Classification
    # ==========================================================================
    # Tier 1: Feature Coverage
    [PSCustomObject]@{
        Id = "TC041"; Program = "Program4"; Tier = "Tier 1"
        Description = "Equilateral triangle (5, 5, 5)"
        Input = "5 5 5`n"
        Expected = @("The triangle is Equilateral")
    },
    [PSCustomObject]@{
        Id = "TC042"; Program = "Program4"; Tier = "Tier 1"
        Description = "Isosceles triangle (side 1 equals side 2: 5, 5, 3)"
        Input = "5 5 3`n"
        Expected = @("The triangle is Isosceles")
    },
    [PSCustomObject]@{
        Id = "TC043"; Program = "Program4"; Tier = "Tier 1"
        Description = "Scalene triangle (classical 3, 4, 5 right triangle)"
        Input = "3 4 5`n"
        Expected = @("The triangle is Scalene")
    },
    [PSCustomObject]@{
        Id = "TC044"; Program = "Program4"; Tier = "Tier 1"
        Description = "Scalene acute triangle (7, 8, 9)"
        Input = "7 8 9`n"
        Expected = @("The triangle is Scalene")
    },
    [PSCustomObject]@{
        Id = "TC045"; Program = "Program4"; Tier = "Tier 1"
        Description = "Large equilateral triangle (100, 100, 100)"
        Input = "100 100 100`n"
        Expected = @("The triangle is Equilateral")
    },
    # Tier 2: Boundary & Corner Cases
    [PSCustomObject]@{
        Id = "TC046"; Program = "Program4"; Tier = "Tier 2"
        Description = "Degenerate collinear triangle (1 + 2 = 3)"
        Input = "1 2 3`n"
        Expected = @("do not form a valid triangle")
    },
    [PSCustomObject]@{
        Id = "TC047"; Program = "Program4"; Tier = "Tier 2"
        Description = "Impossible triangle inequality violation (1 + 2 < 10)"
        Input = "1 2 10`n"
        Expected = @("do not form a valid triangle")
    },
    [PSCustomObject]@{
        Id = "TC048"; Program = "Program4"; Tier = "Tier 2"
        Description = "Zero side length rejection (0, 5, 5)"
        Input = "0 5 5`n"
        Expected = @("do not form a valid triangle")
    },
    [PSCustomObject]@{
        Id = "TC049"; Program = "Program4"; Tier = "Tier 2"
        Description = "Negative side length rejection (-3, 4, 5)"
        Input = "-3 4 5`n"
        Expected = @("do not form a valid triangle")
    },
    [PSCustomObject]@{
        Id = "TC050"; Program = "Program4"; Tier = "Tier 2"
        Description = "Isosceles permutation (side 2 equals side 3: 4, 7, 7)"
        Input = "4 7 7`n"
        Expected = @("The triangle is Isosceles")
    },
    # Tier 3: Parameter Variations
    [PSCustomObject]@{
        Id = "TC051"; Program = "Program4"; Tier = "Tier 3"
        Description = "Isosceles permutation (side 1 equals side 3: 7, 4, 7)"
        Input = "7 4 7`n"
        Expected = @("The triangle is Isosceles")
    },
    [PSCustomObject]@{
        Id = "TC052"; Program = "Program4"; Tier = "Tier 3"
        Description = "Valid near-degenerate scalene (5 + 6 = 11 > 10)"
        Input = "5 6 10`n"
        Expected = @("The triangle is Scalene")
    },
    # Tier 4: Real-World Scenarios
    [PSCustomObject]@{
        Id = "TC053"; Program = "Program4"; Tier = "Tier 4"
        Description = "Civil engineering 5-12-13 integer truss element"
        Input = "5 12 13`n"
        Expected = @("The triangle is Scalene")
    },

    # ==========================================================================
    # PROGRAM 5: Palindrome Number Checker
    # ==========================================================================
    # Tier 1: Feature Coverage
    [PSCustomObject]@{
        Id = "TC054"; Program = "Program5"; Tier = "Tier 1"
        Description = "Standard 3-digit palindrome (121)"
        Input = "121`n"
        Expected = @("121 is a palindrome")
    },
    [PSCustomObject]@{
        Id = "TC055"; Program = "Program5"; Tier = "Tier 1"
        Description = "Even-length 4-digit palindrome (1221)"
        Input = "1221`n"
        Expected = @("1221 is a palindrome")
    },
    [PSCustomObject]@{
        Id = "TC056"; Program = "Program5"; Tier = "Tier 1"
        Description = "Standard 3-digit non-palindrome (321)"
        Input = "321`n"
        Expected = @("321 is not a palindrome")
    },
    [PSCustomObject]@{
        Id = "TC057"; Program = "Program5"; Tier = "Tier 1"
        Description = "Standard 4-digit non-palindrome (1234)"
        Input = "1234`n"
        Expected = @("1234 is not a palindrome")
    },
    [PSCustomObject]@{
        Id = "TC058"; Program = "Program5"; Tier = "Tier 1"
        Description = "5-digit odd-length palindrome (12321)"
        Input = "12321`n"
        Expected = @("12321 is a palindrome")
    },
    # Tier 2: Boundary & Corner Cases
    [PSCustomObject]@{
        Id = "TC059"; Program = "Program5"; Tier = "Tier 2"
        Description = "Single-digit positive palindrome (7)"
        Input = "7`n"
        Expected = @("7 is a palindrome")
    },
    [PSCustomObject]@{
        Id = "TC060"; Program = "Program5"; Tier = "Tier 2"
        Description = "Single-digit zero palindrome (0)"
        Input = "0`n"
        Expected = @("0 is a palindrome")
    },
    [PSCustomObject]@{
        Id = "TC061"; Program = "Program5"; Tier = "Tier 2"
        Description = "Negative number sign asymmetry rejection (-121)"
        Input = "-121`n"
        Expected = @("-121 is not a palindrome")
    },
    [PSCustomObject]@{
        Id = "TC062"; Program = "Program5"; Tier = "Tier 2"
        Description = "Trailing zero non-palindrome (10)"
        Input = "10`n"
        Expected = @("10 is not a palindrome")
    },
    [PSCustomObject]@{
        Id = "TC063"; Program = "Program5"; Tier = "Tier 2"
        Description = "Multiple trailing zeroes non-palindrome (1200)"
        Input = "1200`n"
        Expected = @("1200 is not a palindrome")
    },
    # Tier 3: Parameter Variations
    [PSCustomObject]@{
        Id = "TC064"; Program = "Program5"; Tier = "Tier 3"
        Description = "Palindrome with zero in center (101)"
        Input = "101`n"
        Expected = @("101 is a palindrome")
    },
    [PSCustomObject]@{
        Id = "TC065"; Program = "Program5"; Tier = "Tier 3"
        Description = "6-digit descending non-palindrome (987654)"
        Input = "987654`n"
        Expected = @("987654 is not a palindrome")
    },
    # Tier 4: Real-World Scenarios
    [PSCustomObject]@{
        Id = "TC066"; Program = "Program5"; Tier = "Tier 4"
        Description = "Large 10-digit numerical symmetry stress (1000000001)"
        Input = "1000000001`n"
        Expected = @("1000000001 is a palindrome")
    },

    # ==========================================================================
    # PROGRAM 6: Day of Year Calculation
    # ==========================================================================
    # Tier 1: Feature Coverage
    [PSCustomObject]@{
        Id = "TC067"; Program = "Program6"; Tier = "Tier 1"
        Description = "First day of the year Jan 1 1994 (Day 1)"
        Input = "1`n1`n1994`n"
        Expected = @("Day 1")
    },
    [PSCustomObject]@{
        Id = "TC068"; Program = "Program6"; Tier = "Tier 1"
        Description = "Last day of non-leap year Dec 31 1993 (Day 365)"
        Input = "12`n31`n1993`n"
        Expected = @("Day 365")
    },
    [PSCustomObject]@{
        Id = "TC069"; Program = "Program6"; Tier = "Tier 1"
        Description = "Last day of leap year Dec 31 1996 (Day 366)"
        Input = "12`n31`n1996`n"
        Expected = @("Day 366")
    },
    [PSCustomObject]@{
        Id = "TC070"; Program = "Program6"; Tier = "Tier 1"
        Description = "First day of second month Feb 1 2023 (Day 32)"
        Input = "2`n1`n2023`n"
        Expected = @("Day 32")
    },
    [PSCustomObject]@{
        Id = "TC071"; Program = "Program6"; Tier = "Tier 1"
        Description = "Independence Day in leap year Jul 4 2024 (Day 186)"
        Input = "7`n4`n2024`n"
        Expected = @("Day 186")
    },
    # Tier 2: Boundary & Corner Cases
    [PSCustomObject]@{
        Id = "TC072"; Program = "Program6"; Tier = "Tier 2"
        Description = "Leap day Feb 29 in leap century 2000 (Day 60)"
        Input = "2`n29`n2000`n"
        Expected = @("Day 60")
    },
    [PSCustomObject]@{
        Id = "TC073"; Program = "Program6"; Tier = "Tier 2"
        Description = "Day after leap day Mar 1 in leap century 2000 (Day 61)"
        Input = "3`n1`n2000`n"
        Expected = @("Day 61")
    },
    [PSCustomObject]@{
        Id = "TC074"; Program = "Program6"; Tier = "Tier 2"
        Description = "Mar 1 in non-leap century 1900 (Day 60)"
        Input = "3`n1`n1900`n"
        Expected = @("Day 60")
    },
    [PSCustomObject]@{
        Id = "TC075"; Program = "Program6"; Tier = "Tier 2"
        Description = "Last day of February in non-leap year Feb 28 2023 (Day 59)"
        Input = "2`n28`n2023`n"
        Expected = @("Day 59")
    },
    [PSCustomObject]@{
        Id = "TC076"; Program = "Program6"; Tier = "Tier 2"
        Description = "Invalid month value out of bounds (13)"
        Input = "13`n1`n2023`n"
        Expected = @("Invalid date entered")
    },
    # Tier 3: Parameter Variations
    [PSCustomObject]@{
        Id = "TC077"; Program = "Program6"; Tier = "Tier 3"
        Description = "Future leap century Dec 31 2400 (Day 366)"
        Input = "12`n31`n2400`n"
        Expected = @("Day 366")
    },
    [PSCustomObject]@{
        Id = "TC078"; Program = "Program6"; Tier = "Tier 3"
        Description = "Future non-leap century Dec 31 2100 (Day 365)"
        Input = "12`n31`n2100`n"
        Expected = @("Day 365")
    },
    # Tier 4: Real-World Scenarios
    [PSCustomObject]@{
        Id = "TC079"; Program = "Program6"; Tier = "Tier 4"
        Description = "Non-leap century Feb 29 date rejection (2 29 1900)"
        Input = "2`n29`n1900`n"
        Expected = @("Invalid date entered")
    },
    [PSCustomObject]@{
        Id = "TC080"; Program = "Program6"; Tier = "Tier 4"
        Description = "Mid-year meteorological date Aug 15 2021 (Day 227)"
        Input = "8`n15`n2021`n"
        Expected = @("Day 227")
    },

    # ==========================================================================
    # PROGRAM 7: Prime or Composite Checker
    # ==========================================================================
    # Tier 1: Feature Coverage
    [PSCustomObject]@{
        Id = "TC081"; Program = "Program7"; Tier = "Tier 1"
        Description = "Smallest prime number (2)"
        Input = "2`n"
        Expected = @("Result: Prime")
    },
    [PSCustomObject]@{
        Id = "TC082"; Program = "Program7"; Tier = "Tier 1"
        Description = "Small odd prime number (7)"
        Input = "7`n"
        Expected = @("Result: Prime")
    },
    [PSCustomObject]@{
        Id = "TC083"; Program = "Program7"; Tier = "Tier 1"
        Description = "Two-digit prime number (13)"
        Input = "13`n"
        Expected = @("Result: Prime")
    },
    [PSCustomObject]@{
        Id = "TC084"; Program = "Program7"; Tier = "Tier 1"
        Description = "Smallest composite number (4)"
        Input = "4`n"
        Expected = @("Result: Composite")
    },
    [PSCustomObject]@{
        Id = "TC085"; Program = "Program7"; Tier = "Tier 1"
        Description = "Small odd composite number (9)"
        Input = "9`n"
        Expected = @("Result: Composite")
    },
    # Tier 2: Boundary & Corner Cases
    [PSCustomObject]@{
        Id = "TC086"; Program = "Program7"; Tier = "Tier 2"
        Description = "Unit integer 1 (neither prime nor composite)"
        Input = "1`n"
        Expected = @("neither prime nor composite")
    },
    [PSCustomObject]@{
        Id = "TC087"; Program = "Program7"; Tier = "Tier 2"
        Description = "Zero integer (neither prime nor composite)"
        Input = "0`n"
        Expected = @("neither prime nor composite")
    },
    [PSCustomObject]@{
        Id = "TC088"; Program = "Program7"; Tier = "Tier 2"
        Description = "Negative integer rejection (-7)"
        Input = "-7`n"
        Expected = @("neither prime nor composite")
    },
    [PSCustomObject]@{
        Id = "TC089"; Program = "Program7"; Tier = "Tier 2"
        Description = "Smallest odd prime (3)"
        Input = "3`n"
        Expected = @("Result: Prime")
    },
    [PSCustomObject]@{
        Id = "TC090"; Program = "Program7"; Tier = "Tier 2"
        Description = "Product of two odd primes (15)"
        Input = "15`n"
        Expected = @("Result: Composite")
    },
    # Tier 3: Parameter Variations
    [PSCustomObject]@{
        Id = "TC091"; Program = "Program7"; Tier = "Tier 3"
        Description = "Largest two-digit prime (97)"
        Input = "97`n"
        Expected = @("Result: Prime")
    },
    [PSCustomObject]@{
        Id = "TC092"; Program = "Program7"; Tier = "Tier 3"
        Description = "Square of a prime (49 = 7 * 7)"
        Input = "49`n"
        Expected = @("Result: Composite")
    },
    # Tier 4: Real-World Scenarios
    [PSCustomObject]@{
        Id = "TC093"; Program = "Program7"; Tier = "Tier 4"
        Description = "Cryptographic 3-digit prime (541)"
        Input = "541`n"
        Expected = @("Result: Prime")
    },
    [PSCustomObject]@{
        Id = "TC094"; Program = "Program7"; Tier = "Tier 4"
        Description = "Carmichael pseudoprime composite (561 = 3 * 11 * 17)"
        Input = "561`n"
        Expected = @("Result: Composite")
    },

    # ==========================================================================
    # PROGRAM 8: Greatest Common Divisor (GCD)
    # ==========================================================================
    # Tier 1: Feature Coverage
    [PSCustomObject]@{
        Id = "TC095"; Program = "Program8"; Tier = "Tier 1"
        Description = "Standard common factor pair (54, 24)"
        Input = "54`n24`n"
        Expected = @("GCD: 6")
    },
    [PSCustomObject]@{
        Id = "TC096"; Program = "Program8"; Tier = "Tier 1"
        Description = "Coprime pair with no common factor (17, 19)"
        Input = "17`n19`n"
        Expected = @("GCD: 1")
    },
    [PSCustomObject]@{
        Id = "TC097"; Program = "Program8"; Tier = "Tier 1"
        Description = "Multiple factor pair (12, 36)"
        Input = "12`n36`n"
        Expected = @("GCD: 12")
    },
    [PSCustomObject]@{
        Id = "TC098"; Program = "Program8"; Tier = "Tier 1"
        Description = "Base-10 multiples (100, 25)"
        Input = "100`n25`n"
        Expected = @("GCD: 25")
    },
    [PSCustomObject]@{
        Id = "TC099"; Program = "Program8"; Tier = "Tier 1"
        Description = "Inverted argument order (24, 54)"
        Input = "24`n54`n"
        Expected = @("GCD: 6")
    },
    # Tier 2: Boundary & Corner Cases
    [PSCustomObject]@{
        Id = "TC100"; Program = "Program8"; Tier = "Tier 2"
        Description = "First argument zero (0, 48)"
        Input = "0`n48`n"
        Expected = @("GCD: 48")
    },
    [PSCustomObject]@{
        Id = "TC101"; Program = "Program8"; Tier = "Tier 2"
        Description = "Second argument zero (48, 0)"
        Input = "48`n0`n"
        Expected = @("GCD: 48")
    },
    [PSCustomObject]@{
        Id = "TC102"; Program = "Program8"; Tier = "Tier 2"
        Description = "First argument negative (-54, 24)"
        Input = "-54`n24`n"
        Expected = @("GCD: 6")
    },
    [PSCustomObject]@{
        Id = "TC103"; Program = "Program8"; Tier = "Tier 2"
        Description = "Both arguments negative (-24, -54)"
        Input = "-24`n-54`n"
        Expected = @("GCD: 6")
    },
    [PSCustomObject]@{
        Id = "TC104"; Program = "Program8"; Tier = "Tier 2"
        Description = "Both arguments identical (42, 42)"
        Input = "42`n42`n"
        Expected = @("GCD: 42")
    },
    # Tier 3: Parameter Variations
    [PSCustomObject]@{
        Id = "TC105"; Program = "Program8"; Tier = "Tier 3"
        Description = "Consecutive integers coprime (99, 100)"
        Input = "99`n100`n"
        Expected = @("GCD: 1")
    },
    [PSCustomObject]@{
        Id = "TC106"; Program = "Program8"; Tier = "Tier 3"
        Description = "Multi-digit Euclidean reduction (1071, 462)"
        Input = "1071`n462`n"
        Expected = @("GCD: 21")
    },
    # Tier 4: Real-World Scenarios
    [PSCustomObject]@{
        Id = "TC107"; Program = "Program8"; Tier = "Tier 4"
        Description = "Pi rational approximation coprime pair (355, 113)"
        Input = "355`n113`n"
        Expected = @("GCD: 1")
    },
    [PSCustomObject]@{
        Id = "TC108"; Program = "Program8"; Tier = "Tier 4"
        Description = "Even 4-digit numbers (1234, 5678)"
        Input = "1234`n5678`n"
        Expected = @("GCD: 2")
    },

    # ==========================================================================
    # PROGRAM 9: Daily High Temperatures Analysis
    # ==========================================================================
    # Tier 1: Feature Coverage
    [PSCustomObject]@{
        Id = "TC109"; Program = "Program9"; Tier = "Tier 1"
        Description = "Single hot day reading (90)"
        Input = "90 -99`n"
        Expected = @("Temperature 90 is Hot", "Hot: 1", "Pleasant: 0", "Cold: 0", "Total days: 1")
    },
    [PSCustomObject]@{
        Id = "TC110"; Program = "Program9"; Tier = "Tier 1"
        Description = "Single pleasant day reading (72)"
        Input = "72 -99`n"
        Expected = @("Temperature 72 is Pleasant", "Hot: 0", "Pleasant: 1", "Cold: 0", "Total days: 1")
    },
    [PSCustomObject]@{
        Id = "TC111"; Program = "Program9"; Tier = "Tier 1"
        Description = "Single cold day reading (45)"
        Input = "45 -99`n"
        Expected = @("Temperature 45 is Cold", "Hot: 0", "Pleasant: 0", "Cold: 1", "Total days: 1")
    },
    [PSCustomObject]@{
        Id = "TC112"; Program = "Program9"; Tier = "Tier 1"
        Description = "One reading in each category (88 70 50)"
        Input = "88 70 50 -99`n"
        Expected = @("Hot: 1", "Pleasant: 1", "Cold: 1", "Total days: 3")
    },
    [PSCustomObject]@{
        Id = "TC113"; Program = "Program9"; Tier = "Tier 1"
        Description = "Multiple pleasant days (65 75 80)"
        Input = "65 75 80 -99`n"
        Expected = @("Hot: 0", "Pleasant: 3", "Cold: 0", "Total days: 3")
    },
    # Tier 2: Boundary & Corner Cases
    [PSCustomObject]@{
        Id = "TC114"; Program = "Program9"; Tier = "Tier 2"
        Description = "Exact Hot lower boundary threshold (85)"
        Input = "85 -99`n"
        Expected = @("Temperature 85 is Hot", "Hot: 1")
    },
    [PSCustomObject]@{
        Id = "TC115"; Program = "Program9"; Tier = "Tier 2"
        Description = "Exact Pleasant upper boundary threshold (84)"
        Input = "84 -99`n"
        Expected = @("Temperature 84 is Pleasant", "Pleasant: 1")
    },
    [PSCustomObject]@{
        Id = "TC116"; Program = "Program9"; Tier = "Tier 2"
        Description = "Exact Pleasant lower boundary threshold (60)"
        Input = "60 -99`n"
        Expected = @("Temperature 60 is Pleasant", "Pleasant: 1")
    },
    [PSCustomObject]@{
        Id = "TC117"; Program = "Program9"; Tier = "Tier 2"
        Description = "Exact Cold upper boundary threshold (59)"
        Input = "59 -99`n"
        Expected = @("Temperature 59 is Cold", "Cold: 1")
    },
    [PSCustomObject]@{
        Id = "TC118"; Program = "Program9"; Tier = "Tier 2"
        Description = "Sub-zero freezing temperature (-15)"
        Input = "-15 -99`n"
        Expected = @("Temperature -15 is Cold", "Cold: 1")
    },
    # Tier 3: Parameter Variations
    [PSCustomObject]@{
        Id = "TC119"; Program = "Program9"; Tier = "Tier 3"
        Description = "Immediate sentinel termination (empty stream)"
        Input = "-99`n"
        Expected = @("Hot: 0", "Pleasant: 0", "Cold: 0", "Total days: 0")
    },
    [PSCustomObject]@{
        Id = "TC120"; Program = "Program9"; Tier = "Tier 3"
        Description = "Boundary threshold alternation cycle (85 84 60 59)"
        Input = "85 84 60 59 -99`n"
        Expected = @("Hot: 1", "Pleasant: 2", "Cold: 1", "Total days: 4")
    },
    # Tier 4: Real-World Scenarios
    [PSCustomObject]@{
        Id = "TC121"; Program = "Program9"; Tier = "Tier 4"
        Description = "25-day weather station sequence benchmark"
        Input = "55 62 68 74 59 45 41 58 60 67 65 78 82 88 91 92 90 93 87 78 79 72 68 61 59 -99`n"
        Expected = @("Hot: 6", "Pleasant: 13", "Cold: 6", "Total days: 25")
    },
    [PSCustomObject]@{
        Id = "TC122"; Program = "Program9"; Tier = "Tier 4"
        Description = "Summer heatwave multi-day sequence"
        Input = "95 102 88 91 89 -99`n"
        Expected = @("Hot: 5", "Pleasant: 0", "Cold: 0", "Total days: 5")
    },

    # ==========================================================================
    # PROGRAM 10: Exam Scores and Grade Distribution
    # ==========================================================================
    # Tier 1: Feature Coverage
    [PSCustomObject]@{
        Id = "TC123"; Program = "Program10"; Tier = "Tier 1"
        Description = "Single grade A exam score (95)"
        Input = "95 -1`n"
        Expected = @("Total = 1", "A = 1", "B = 0", "C = 0", "D = 0", "F = 0")
    },
    [PSCustomObject]@{
        Id = "TC124"; Program = "Program10"; Tier = "Tier 1"
        Description = "Single grade B exam score (85)"
        Input = "85 -1`n"
        Expected = @("Total = 1", "A = 0", "B = 1", "C = 0", "D = 0", "F = 0")
    },
    [PSCustomObject]@{
        Id = "TC125"; Program = "Program10"; Tier = "Tier 1"
        Description = "Single grade C exam score (75)"
        Input = "75 -1`n"
        Expected = @("Total = 1", "A = 0", "B = 0", "C = 1", "D = 0", "F = 0")
    },
    [PSCustomObject]@{
        Id = "TC126"; Program = "Program10"; Tier = "Tier 1"
        Description = "Single grade D exam score (65)"
        Input = "65 -1`n"
        Expected = @("Total = 1", "A = 0", "B = 0", "C = 0", "D = 1", "F = 0")
    },
    [PSCustomObject]@{
        Id = "TC127"; Program = "Program10"; Tier = "Tier 1"
        Description = "Single grade F exam score (45)"
        Input = "45 -1`n"
        Expected = @("Total = 1", "A = 0", "B = 0", "C = 0", "D = 0", "F = 1")
    },
    # Tier 2: Boundary & Corner Cases
    [PSCustomObject]@{
        Id = "TC128"; Program = "Program10"; Tier = "Tier 2"
        Description = "Immediate sentinel termination (-1)"
        Input = "-1`n"
        Expected = @("Total = 0", "A = 0", "B = 0", "C = 0", "D = 0", "F = 0")
    },
    [PSCustomObject]@{
        Id = "TC129"; Program = "Program10"; Tier = "Tier 2"
        Description = "Perfect score upper boundary (100)"
        Input = "100 -1`n"
        Expected = @("Total = 1", "A = 1")
    },
    [PSCustomObject]@{
        Id = "TC130"; Program = "Program10"; Tier = "Tier 2"
        Description = "Grade boundaries between A and B (90, 89)"
        Input = "90 89 -1`n"
        Expected = @("Total = 2", "A = 1", "B = 1")
    },
    [PSCustomObject]@{
        Id = "TC131"; Program = "Program10"; Tier = "Tier 2"
        Description = "Cutoff boundaries across B, C, D, F (80 79 70 69 60 59)"
        Input = "80 79 70 69 60 59 -1`n"
        Expected = @("Total = 6", "B = 1", "C = 2", "D = 2", "F = 1")
    },
    [PSCustomObject]@{
        Id = "TC132"; Program = "Program10"; Tier = "Tier 2"
        Description = "Absolute zero minimum score boundary (0)"
        Input = "0 -1`n"
        Expected = @("Total = 1", "F = 1")
    },
    # Tier 3: Parameter Variations
    [PSCustomObject]@{
        Id = "TC133"; Program = "Program10"; Tier = "Tier 3"
        Description = "Out of range score (>100) ignored"
        Input = "105 85 -1`n"
        Expected = @("Invalid score ignored", "Total = 1", "B = 1")
    },
    [PSCustomObject]@{
        Id = "TC134"; Program = "Program10"; Tier = "Tier 3"
        Description = "Alternate negative sentinel (-99)"
        Input = "92 -99`n"
        Expected = @("Total = 1", "A = 1")
    },
    # Tier 4: Real-World Scenarios
    [PSCustomObject]@{
        Id = "TC135"; Program = "Program10"; Tier = "Tier 4"
        Description = "Official CpE 02 benchmark grade distribution (14 scores)"
        Input = "98 87 86 85 85 78 73 72 72 72 70 66 63 50 -1`n"
        Expected = @("Total = 14", "A = 1", "B = 4", "C = 6", "D = 2", "F = 1")
    },
    [PSCustomObject]@{
        Id = "TC136"; Program = "Program10"; Tier = "Tier 4"
        Description = "Classroom section curve distribution (11 scores)"
        Input = "95 91 88 84 82 77 75 70 68 55 40 -1`n"
        Expected = @("Total = 11", "A = 2", "B = 3", "C = 3", "D = 1", "F = 2")
    }
)

# Filter test cases if requested
if (-not [string]::IsNullOrEmpty($FilterProgram)) {
    $testSuite = $testSuite | Where-Object { $_.Program -eq $FilterProgram }
    Write-Host "Filtered to program: $FilterProgram ($($testSuite.Count) tests)" -ForegroundColor Yellow
}

function Invoke-SingleTest {
    param (
        [PSCustomObject]$Test,
        [string]$JavaPath,
        [string]$WorkingDir,
        [int]$Timeout
    )

    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = $JavaPath
    $psi.Arguments = "-cp . $($Test.Program)"
    $psi.WorkingDirectory = $WorkingDir
    $psi.RedirectStandardInput = $true
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true
    $psi.UseShellExecute = $false
    $psi.CreateNoWindow = $true

    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    $proc = [System.Diagnostics.Process]::Start($psi)

    if (-not [string]::IsNullOrEmpty($Test.Input)) {
        $proc.StandardInput.Write($Test.Input)
    }
    $proc.StandardInput.Close()

    $stdoutTask = $proc.StandardOutput.ReadToEndAsync()
    $stderrTask = $proc.StandardError.ReadToEndAsync()

    $exitedInTime = $proc.WaitForExit($Timeout)
    $stopwatch.Stop()

    if (-not $exitedInTime) {
        try { $proc.Kill() } catch {}
        return [PSCustomObject]@{
            Id = $Test.Id
            Program = $Test.Program
            Tier = $Test.Tier
            Description = $Test.Description
            Passed = $false
            DurationMs = $stopwatch.ElapsedMilliseconds
            Error = "TIMEOUT (execution exceeded $Timeout ms)"
            Stdout = ""
            Stderr = ""
        }
    }

    $stdout = $stdoutTask.Result
    $stderr = $stderrTask.Result

    $passed = $true
    $failureReason = ""

    foreach ($exp in $Test.Expected) {
        if ($exp.StartsWith("regex:")) {
            $pattern = $exp.Substring(6)
            if (-not ($stdout -match $pattern)) {
                $passed = $false
                $failureReason = "Regex pattern not matched: '$pattern'"
                break
            }
        } else {
            if (-not $stdout.Contains($exp)) {
                $passed = $false
                $failureReason = "Expected substring not found: '$exp'"
                break
            }
        }
    }

    return [PSCustomObject]@{
        Id = $Test.Id
        Program = $Test.Program
        Tier = $Test.Tier
        Description = $Test.Description
        Passed = $passed
        DurationMs = $stopwatch.ElapsedMilliseconds
        Error = $failureReason
        Stdout = $stdout
        Stderr = $stderr
    }
}

# Run the test suite
$totalStopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$results = @()
$passedTests = 0
$failedTests = 0

foreach ($test in $testSuite) {
    $res = Invoke-SingleTest -Test $test -JavaPath $JavaBin -WorkingDir $ScriptDir -Timeout $TimeoutMs
    $results += $res

    if ($res.Passed) {
        $passedTests++
        Write-Host ("[PASS] {0,-7} | {1,-10} | {2,-7} | {3}" -f $res.Id, $res.Program, $res.Tier, $res.Description) -ForegroundColor Green
    } else {
        $failedTests++
        Write-Host ("[FAIL] {0,-7} | {1,-10} | {2,-7} | {3}" -f $res.Id, $res.Program, $res.Tier, $res.Description) -ForegroundColor Red
        Write-Host ("       Reason: {0}" -f $res.Error) -ForegroundColor DarkYellow
        Write-Host ("       Stdout: {0}" -f ($res.Stdout.Trim() -replace "\r?\n", " ")) -ForegroundColor DarkGray
        if ($res.Stderr) {
            Write-Host ("       Stderr: {0}" -f $res.Stderr.Trim()) -ForegroundColor DarkRed
        }
    }
}

$totalStopwatch.Stop()
$totalTests = $results.Count

# Print final summary table
Write-Host ""
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "                       CPE02 TEST EXECUTION SUMMARY" -ForegroundColor Cyan
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host ("Total Tests Run : {0}" -f $totalTests)
Write-Host ("Passed          : {0}" -f $passedTests) -ForegroundColor Green
Write-Host ("Failed          : {0}" -f $failedTests) -ForegroundColor $(if ($failedTests -gt 0) { "Red" } else { "Green" })
Write-Host ("Success Rate    : {0:P2}" -f ($passedTests / [Math]::Max(1, $totalTests)))
Write-Host ("Total Duration  : {0:N2} seconds" -f ($totalStopwatch.Elapsed.TotalSeconds))
Write-Host "================================================================================" -ForegroundColor Cyan

if ($failedTests -gt 0) {
    Write-Host "TEST SUITE STATUS: FAILED ($failedTests tests failed)" -ForegroundColor Red
    exit 1
} else {
    Write-Host "TEST SUITE STATUS: ALL TESTS PASSED (100%)" -ForegroundColor Green
    exit 0
}
