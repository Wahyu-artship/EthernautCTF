# Level 18 - Magic Number

## Challenge
Deploy a contract to `solver` that is at most 10 bytes of bytecode and returns 42 when called. This is impossible using standard Solidity, since even the simplest contract compiles to bytecode far exceeding 10 bytes due to compiler overhead - the only way is hand-writing raw EVM opcodes.

## Solution
**Runtime code (10 bytes):** `602a60005260206000f3`

60 2a PUSH1 0x2a ; push 42 onto the stack
60 00 PUSH1 0x00 ; push memory offset 0
52 MSTORE ; store 42 at memory position 0
60 20 PUSH1 0x20 ; push return size (32 bytes)
60 00 PUSH1 0x00 ; push memory offset to return from
f3 RETURN ; return the 32 bytes containing 42


**Init code** (runs once at deployment, copies the runtime code into permanent storage):

600a600c600039600a6000f3


**Full deployment bytecode:** `600a600c600039600a6000f3602a60005260206000f3`

Deployed directly via `cast send --create <bytecode>`, bypassing Solidity entirely.

## Instance
- Solver contract: 0xefeCc799AC13ccB51bD2d3B9E365A32deb936b6E
- Network: Sepolia
