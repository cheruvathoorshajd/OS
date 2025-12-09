

***

# OS - Assembly Operating System

**Author:** Dennis Sharon Chervathoor Shaj
**Language:** x86 Assembly (NASM Syntax)  
**Project Type:** Bootable Operating System Modules

***

## Project Overview

This OS is a simple operating system implemented in x86 assembly language, consisting of three independent bootable modules that demonstrate fundamental OS concepts including file system operations, arithmetic computation, and memory management. The project contains **12 distinct functions** across approximately **325 lines of assembly code**.

***

## Project Structure

```
dennis_os_assignment/
├── dennis_os.asm              # Main OS module - File operations
├── dennis_os_compute.asm      # Compute engine - Arithmetic operations
├── dennis_os_memory.asm       # Memory manager - Memory operations
├── dennis_os.lst              # Assembly listing file
├── dennis_os_compute.lst      # Assembly listing file
├── dennis_os_memory.lst       # Assembly listing file
├── screenshots/               # QEMU execution screenshots
├── report                     # One Page as mentuioned in the requirnment
└── README.md                  # This file
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
- **Windows**: MSYS2 or MinGW environment (optional for shell scripts)
- **Linux/Mac**: Native terminal

### Installation

#### Windows (MSYS2/MinGW)
```bash
# Install NASM
pacman -S nasm

# Install QEMU
pacman -S mingw-w64-x86_64-qemu
```

#### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install nasm qemu-system-x86
```

#### macOS (Homebrew)
```bash
brew install nasm qemu
```

***

## How to Build and Run

### Step 1: Compile Assembly Code

Compile each module into a binary bootable image:

```bash
# Compile Main OS Module
nasm -f bin dennis_os.asm -o dennis_os.bin

# Compile Compute Engine
nasm -f bin dennis_os_compute.asm -o dennis_os_compute.bin

# Compile Memory Manager
nasm -f bin dennis_os_memory.asm -o dennis_os_memory.bin
```

### Step 2: Run in QEMU Emulator

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

### Step 3: Expected Output

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

***


## References

- [OSDev Wiki - Bootloader](https://wiki.osdev.org/Bootloader)
- [NASM Documentation](https://www.nasm.us/docs.php)
- [BIOS Interrupt Calls](https://en.wikipedia.org/wiki/BIOS_interrupt_call)
- [x86 Assembly Guide](https://www.cs.virginia.edu/~evans/cs216/guides/x86.html)

***
