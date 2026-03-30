#!/bin/bash

BINARY="./vulnprog"

echo "Secret Functions in $BINARY:"
echo ""

# basic ideas:
# secrets start with endbr64 and push %rbp
# call puts@plt
# extract function entry points between 0x1249 and 0x149e (edit function at 0x149f)
COUNT=0
objdump -d "$BINARY" | awk '
/^[[:space:]]+[0-9a-f]+:/ {
    addr = strtonum("0x" substr($1, 1, length($1)-1))
    # Only look in the secret function range
    if (addr >= 0x1249 && addr < 0x149f) {
        # Match endbr64 lines that start a new function
        if ($2 == "f3" && $3 == "0f" && $4 == "1e" && $5 == "fa") {
            count++
            printf "Secret %2d:  offset = 0x%04x  |  runtime = 0x%x\n", count, addr, 0x555555554000 + addr
        }
    }
}
'

echo ""
echo "Base address may differ inside your Multipass VM, please change accordingly"