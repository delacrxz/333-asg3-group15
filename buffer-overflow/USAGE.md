## Find the Base & Exit Addresses
After disabling ASLR using the commands in the assignment, run in terminal:
```bash
gdb ./vulnprog
(gdb) starti
(gdb) info proc mappings    # the base address BASE is the Start Addr in the first line of Mapped address spaces
(gdb) break *(BASE + 0x1542)    # set a breakpoint on main to load libc next
(gdb) continue
(gdb) p exit    # get exit() address EXIT_ADDR
(gdb) quit
```
Replace `BASE` and `EXIT_ADDR` in `exploit.py`.


## Extract the Offsets of Secret Functions
Run 'extract_secrets.sh':
```bash
chmod +x extract_secrets.sh
./extract_secrets.sh
```
Expected Output:
```bash
Secret Functions in ./vulnprog:

Secret  1: offset = 0x1249
Secret  2: offset = 0x1263
Secret  3: offset = 0x127d
Secret  4: offset = 0x1297
Secret  5: offset = 0x12b1
Secret  6: offset = 0x12cb
Secret  7: offset = 0x12e5
Secret  8: offset = 0x12ff
Secret  9: offset = 0x1319
Secret 10: offset = 0x1333
Secret 11: offset = 0x134d
Secret 12: offset = 0x1367
Secret 13: offset = 0x1381
Secret 14: offset = 0x139b
Secret 15: offset = 0x13b5
Secret 16: offset = 0x13cf
Secret 17: offset = 0x13e9
Secret 18: offset = 0x1403
Secret 19: offset = 0x141d
Secret 20: offset = 0x1437
Secret 21: offset = 0x1451
Secret 22: offset = 0x146b
Secret 23: offset = 0x1485
```
Group 15's secret function is at offset `0x13b5`. If you wish to test with other functions, change the offset value in `SECRET_15` in `exploit.py` as well.


## Exploit
Run `exploit.py`:
```bash
python3 exploit.py
```
Expected Output (pid could be different, that's fine):
```bash
[+] Starting local process './vulnprog': pid 19443
[+] Receiving all data: Done (34B)
[*] Process './vulnprog' stopped with exit code 16 (pid 19443)
SECRET CMPUT 333 Group 15 reached
```
This process should exit without crashing.