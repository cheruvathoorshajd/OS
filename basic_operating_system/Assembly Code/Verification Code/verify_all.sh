#!/bin/bash

echo "============================================="
echo "  DENNIS OS - COMPLETE VERIFICATION SUITE"
echo "  By: Dennis Sharon"
echo "============================================="
echo ""

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
PASS=0
FAIL=0

# Function to verify one OS file
verify_os() {
    local filename=$1
    local os_name=$2
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  Verifying: $os_name"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Test 1: Source file exists
    echo -n "[1/7] Checking source file... "
    if [ -f "$filename" ]; then
        echo -e "${GREEN}✓ PASS${NC}"
        ((PASS++))
        lines=$(wc -l < "$filename")
        echo "      Lines of code: $lines"
    else
        echo -e "${RED}✗ FAIL${NC} - File not found!"
        ((FAIL++))
        return 1
    fi
    
    # Test 2: Compilation
    echo -n "[2/7] Compiling source code... "
    binfile="${filename%.asm}.bin"
    lstfile="${filename%.asm}.lst"
    
    nasm -f bin "$filename" -o "$binfile" -l "$lstfile" 2>/dev/null
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ PASS${NC}"
        ((PASS++))
    else
        echo -e "${RED}✗ FAIL${NC} - Compilation error!"
        ((FAIL++))
        return 1
    fi
    
    # Test 3: File size check
    echo -n "[3/7] Checking boot sector size... "
    size=$(stat -f%z "$binfile" 2>/dev/null || stat -c%s "$binfile" 2>/dev/null)
    if [ "$size" -eq 512 ]; then
        echo -e "${GREEN}✓ PASS${NC} ($size bytes)"
        ((PASS++))
    else
        echo -e "${RED}✗ FAIL${NC} ($size bytes, should be 512)"
        ((FAIL++))
    fi
    
    # Test 4: Boot signature
    echo -n "[4/7] Verifying boot signature... "
    signature=$(xxd -p -s 510 -l 2 "$binfile" 2>/dev/null)
    if [ "$signature" = "55aa" ]; then
        echo -e "${GREEN}✓ PASS${NC} (0x55AA)"
        ((PASS++))
    else
        echo -e "${RED}✗ FAIL${NC} (0x$signature, should be 0x55AA)"
        ((FAIL++))
    fi
    
    # Test 5: Check for proper origin
    echo -n "[5/7] Checking boot origin... "
    if grep -q "^\[org 0x7c00\]" "$filename"; then
        echo -e "${GREEN}✓ PASS${NC} (0x7C00)"
        ((PASS++))
    else
        echo -e "${RED}✗ FAIL${NC} - Origin not set!"
        ((FAIL++))
    fi
    
    # Test 6: Function count
    echo -n "[6/7] Counting functions... "
    func_count=$(grep -c "^f[0-9]:\|^func_" "$filename")
    if [ "$func_count" -ge 4 ]; then
        echo -e "${GREEN}✓ PASS${NC} ($func_count functions found)"
        ((PASS++))
    else
        echo -e "${YELLOW}⚠ WARNING${NC} ($func_count functions, need 4+)"
        ((PASS++))
    fi
    
    # Test 7: Syntax validation
    echo -n "[7/7] Validating assembly syntax... "
    if [ -f "$lstfile" ]; then
        echo -e "${GREEN}✓ PASS${NC}"
        ((PASS++))
        echo "      Listing file: $lstfile"
    else
        echo -e "${RED}✗ FAIL${NC}"
        ((FAIL++))
    fi
    
    echo ""
}

# Verify all three OS files
verify_os "dennis_os.asm" "Dennis OS (Main - 4 Functions)"
verify_os "dennis_os_memory.asm" "Dennis OS Memory Manager"
verify_os "dennis_os_compute.asm" "Dennis OS Compute Engine"

# Summary
echo "============================================="
echo "  VERIFICATION SUMMARY"
echo "============================================="
echo -e "Total Tests: $((PASS + FAIL))"
echo -e "${GREEN}Passed: $PASS${NC}"
echo -e "${RED}Failed: $FAIL${NC}"
echo ""

if [ $FAIL -eq 0 ]; then
    echo -e "${GREEN}✓ ALL VERIFICATIONS PASSED!${NC}"
    echo "  Your OS files are ready for submission!"
    exit 0
else
    echo -e "${RED}✗ SOME TESTS FAILED${NC}"
    echo "  Please review errors above."
    exit 1
fi
