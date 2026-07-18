# Level 05 - Token

## Vulnerability
This contract uses Solidity ^0.6.0, which has no automatic overflow/underflow protection (introduced later in 0.8.0). The transfer function checks `require(balances[msg.sender] - _value >= 0)`, but since `balances[msg.sender]` is `uint256` (unsigned), this check is meaningless - an unsigned integer subtraction can never produce a negative result. If it underflows, it wraps around to a massive number close to `2^256 - 1`, which still satisfies `>= 0`.

## Exploit steps
1. Check current balance (starts at 20 tokens).
2. Call `transfer()` with a value greater than the current balance (e.g. transfer 21 when holding 20).
3. The subtraction underflows, wrapping the sender's balance to an astronomically large number instead of reverting.

## Instance
- Level address: 0x478f3476358Eb166Cb7adE4666d04fbdDB56C407
- Instance address: 0x95e57F015422E8730C3d4125c454db0C3d725aE7
- Network: Sepolia
