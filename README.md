
***

# OS - Assembly Operating System Project

**Author:** Dennis Sharon 
**Language:** x86 Assembly (NASM Syntax)  
**Project Type:** Bootable Operating System Modules

***

## Project Overview

Dennis OS is a simple operating system implemented in x86 assembly language, consisting of three independent bootable modules that demonstrate fundamental OS concepts including file system operations, arithmetic computation, and memory management. The project contains **12 distinct functions** across approximately **325 lines of assembly code**.

***

## Project Structure

```
DENNIS-OS-ASSIGNMNET/
│
├── Assembly Code/
│   └── Verification Code/
│       └── verify_all.sh                    # Automated verification script
│   ├── dennis_os_compute.asm                # Compute engine source
│   ├── dennis_os_compute.bin                # Compiled compute engine
│   ├── dennis_os_compute.lst                # Assembly listing
│   ├── dennis_os_memory.asm                 # Memory manager source
│   ├── dennis_os_memory.bin                 # Compiled memory manager
│   ├── dennis_os_memory.lst                 # Assembly listing
│   ├── dennis_os.asm                        # Main OS source
│   ├── dennis_os.bin                        # Compiled main OS
│   └── dennis_os.lst                        # Assembly listing
│
├── Report/
│   └── Final Report.pdf                     # Project documentation
│
├── Screenshots/
│   ├── Code Output Screenshots.pdf          # Execution screenshots
│   └── Environment Implementation Screenshots... # Setup screenshots
│
└── readme.md                                 # This file
```

***

## Features Implemented

### Module 1: Dennis OS (dennis_os.asm)
**4 File System Functions:**
- **LIST**: Display file system contents (file1.txt, file2.dat, file3.bin)
- **MOVE**: Move data between memory addresses (0x9500 → 0x9600)
- **RENAME**: Rename files and assign unique identifiers
- **DELETE**: Clear memory locations and simulate file deletion

### Module 2: Compute Engine (dennis_os_compute.asm)
**4 Arithmetic Functions:**
- **ADD**: Addition operation (0x1234 + 0x5678)
- **SUB**: Subtraction operation (0xFFFF - 0x1111)
- **CMP**: Comparison operation (equality check)
- **MUL**: Multiplication by 2 using left shift

### Module 3: Memory Manager (dennis_os_memory.asm)
**4 Memory Functions:**
- **ALLOC**: Allocate memory at address 0x9500
- **READ**: Read value from memory address
- **COPY**: Copy data from one memory location to another (0x9500 → 0x9600)
- **CLEAR**: Clear memory location (set to 0x0000)

***

## System Requirements

### Software Prerequisites
- **NASM Assembler** (Netwide Assembler) v2.14 or higher
- **QEMU Emulator** (qemu-system-x86_64) v4.0 or higher
- **Bash Shell** (for verification script)
- **xxd** (hex dump utility, usually pre-installed)
- **Windows**: MSYS2 or MinGW environment
- **Linux/Mac**: Native terminal

### Installation

#### Windows (MSYS2/MinGW)
```bash
# Install NASM
pacman -S nasm

# Install QEMU
pacman -S mingw-w64-x86_64-qemu

# xxd is usually included with vim
pacman -S vim
```

#### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install nasm qemu-system-x86 xxd
```

#### macOS (Homebrew)
```bash
brew install nasm qemu
```

***

## How to Build and Run

### Option 1: Manual Compilation and Execution

#### Step 1: Navigate to Assembly Code Directory

```bash
cd "Assembly Code"
```

#### Step 2: Compile Assembly Code

Compile each module into a binary bootable image:

```bash
# Compile Main OS Module
nasm -f bin dennis_os.asm -o dennis_os.bin

# Compile Compute Engine
nasm -f bin dennis_os_compute.asm -o dennis_os_compute.bin

# Compile Memory Manager
nasm -f bin dennis_os_memory.asm -o dennis_os_memory.bin
```

#### Step 3: Run in QEMU Emulator

Execute each binary in QEMU:

```bash
# Run Main OS Module
qemu-system-x86_64 dennis_os.bin

# Run Compute Engine
qemu-system-x86_64 dennis_os_compute.bin

# Run Memory Manager
qemu-system-x86_64 dennis_os_memory.bin
```

**Alternative:** Use `-nographic` for console output only:
```bash
qemu-system-x86_64 -nographic dennis_os.bin
```

***

### Option 2: Automated Verification Script (Recommended)

The project includes a comprehensive verification script that automatically tests all modules.

#### Navigate to Verification Directory

```bash
cd "Assembly Code/Verification Code"
```

#### Make Script Executable

```bash
chmod +x verify_all.sh
```

#### Run Verification

```bash
./verify_all.sh
```

**Note:** The script expects to be run from the `Assembly Code` directory or you need to adjust paths:

```bash
# If running from project root
cd "Assembly Code"
./Verification\ Code/verify_all.sh

# Or run from Verification Code directory after copying script to parent
cd "Assembly Code/Verification Code"
cp verify_all.sh ..
cd ..
./verify_all.sh
```

#### What the Script Tests

The `verify_all.sh` script performs **7 automated tests** for each module:

1. **Source File Check**: Verifies `.asm` file exists and counts lines of code
2. **Compilation Test**: Compiles assembly to binary with error checking
3. **Boot Sector Size**: Validates binary is exactly 512 bytes
4. **Boot Signature**: Confirms boot signature is `0x55AA`
5. **Origin Address**: Checks for proper boot origin at `0x7C00`
6. **Function Count**: Verifies at least 4 functions are implemented
7. **Syntax Validation**: Generates listing file to confirm clean assembly

#### Expected Output

```bash
=============================================
 DENNIS OS - COMPLETE VERIFICATION SUITE
 By: Dennis Sharon
=============================================

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 Verifying: Dennis OS (Main - 4 Functions)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[1/7] Checking source file... ✓ PASS
 Lines of code: 120
[2/7] Compiling source code... ✓ PASS
[3/7] Checking boot sector size... ✓ PASS (512 bytes)
[4/7] Verifying boot signature... ✓ PASS (0x55AA)
[5/7] Checking boot origin... ✓ PASS (0x7C00)
[6/7] Counting functions... ✓ PASS (4 functions found)
[7/7] Validating assembly syntax... ✓ PASS
 Listing file: dennis_os.lst

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 Verifying: Dennis OS Memory Manager
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[1/7] Checking source file... ✓ PASS
...

=============================================
 VERIFICATION SUMMARY
=============================================
Total Tests: 21
Passed: 21
Failed: 0

✓ ALL VERIFICATIONS PASSED!
 Your OS files are ready for submission!
```

***

## Expected Output

Each module will display a banner followed by the execution of all functions with status indicators `[OK]`.

**Example Output (dennis_os.bin):**
```
==========================
 DENNIS OS v1.0
 By: Dennis Sharon
==========================

[1. LIST]
 file1.txt
 file2.dat
 file3.bin [OK]

[2. MOVE]
 0x9500->0x9600: 0x0000 [OK]

[3. RENAME]
 old.txt -> new.txt
 ID: 0xDEAD [OK]

[4. DELETE]
 file1.txt cleared: 0x0000 [OK]
```

***

## Technical Details

### Architecture
- **Target Platform:** x86 (16-bit real mode)
- **Boot Sector Size:** 512 bytes (510 bytes code + 2 bytes boot signature 0xAA55)
- **Memory Layout:**
  - Code origin: 0x7C00 (standard boot sector location)
  - Stack: 0x9000
  - Data storage: 0x9500 - 0x9700

### Assembly Features Used
- BIOS interrupts (INT 0x10 for video output)
- Register manipulation (AX, BX, CX, DX, SI)
- Memory addressing and data movement
- String operations (LODSB)
- Bitwise operations (ROL, SHL, AND)
- Control flow (conditional jumps, function calls)
- Hexadecimal output formatting

***

## Code Statistics

| Module | Lines of Code | Functions | Boot Size |
|--------|---------------|-----------|-----------|
| dennis_os.asm | ~120 | 4 + 3 helpers | 512 bytes |
| dennis_os_compute.asm | ~100 | 4 + 2 helpers | 512 bytes |
| dennis_os_memory.asm | ~105 | 4 + 2 helpers | 512 bytes |
| **Total** | **~325** | **12** | **1536 bytes** |

***

## Troubleshooting

### Error: "TIMES value is negative"
- **Cause:** Code exceeds 510 bytes
- **Solution:** Reduce string lengths or optimize code

### QEMU Window Closes Immediately
- **Cause:** Assembly error or incorrect binary format
- **Solution:** Check compilation errors with `nasm -f bin file.asm -o file.bin -l file.lst`

### No Output in QEMU
- **Cause:** Boot signature missing or incorrect
- **Solution:** Verify last line contains `dw 0xaa55`

### Verification Script Fails on Windows
- **Cause:** Line endings or missing bash shell
- **Solution:** Run in MSYS2/MinGW or Git Bash environment

### Verification Script Cannot Find Files
- **Cause:** Script running from wrong directory
- **Solution:** Run from `Assembly Code` directory where all `.asm` files are located

***

## Manual Verification

To manually verify the boot sector signature:

```bash
# Navigate to Assembly Code directory
cd "Assembly Code"

# Check last 2 bytes should be 55 AA (little-endian)
xxd dennis_os.bin | tail -n 1
```

Expected output:
```
000001f0: ... ... ... ... ... ... ... ... ... ... ... ... ... 55aa
```

To check file size:
```bash
# Linux/Mac
ls -l dennis_os.bin

# Windows (PowerShell)
Get-Item dennis_os.bin

# Should output exactly 512 bytes
```

***

## Quick Start Guide

For fastest setup and verification:

```bash
# 1. Navigate to Assembly Code directory
cd "Assembly Code"

# 2. Make script executable
chmod +x "Verification Code/verify_all.sh"

# 3. Run automated verification
./Verification\ Code/verify_all.sh

# 4. If all tests pass, run any module
qemu-system-x86_64 dennis_os.bin
```

***

## Documentation

Refer to the following documents in the project:

- **Final Report.pdf**: Complete project documentation, design decisions, and implementation details
- **Code Output Screenshots.pdf**: Visual documentation of all three modules executing in QEMU
- **Environment Implementation Screenshots**: Setup and configuration documentation

***

## References

- [OSDev Wiki - Bootloader](https://wiki.osdev.org/Bootloader)
- [NASM Documentation](https://www.nasm.us/docs.php)
- [BIOS Interrupt Calls](https://en.wikipedia.org/wiki/BIOS_interrupt_call)
- [x86 Assembly Guide](https://www.cs.virginia.edu/~evans/cs216/guides/x86.html)

***

