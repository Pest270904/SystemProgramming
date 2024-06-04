# NT209 Lab and Things

## **Progress**:
- Lab 1: 10.5/10
- Lab 2: 4/4 (0/1 advanced)
- Lab 3: 4/4 (1/2 advanced)
- Lab 4: 3/3
- Lab 5: 5/5
- Lab 6: 4/4

## Notes:
- To run any assembly file fast:
    ```bash
    $ as -o a.o [ProgramName].s ; ld -o a a.o ; ./a
    ```
    for example your file named **code.s** then [ProgramName] is "code": 
    ```bash
    $ as -o a.o code.s ; ld -o a a.o ; ./a  
    ```

- To compile execute codes for **Lab 6**:
    ```bash
    $ as --32 [ProgramName].s -o [OuputFileName].o
        or
    $ gcc -m32 -c [ProgramName].s - o [OutputFileName].o
    ```

- To view disassembly of object file (.o):
    ```bash
    $ objdump -d [FileName].o
    ```

- Tools used: IDA Pro 7.7,...

- __**(!!!!) Feel free to take it as references but please don't copy 100% 💕**__