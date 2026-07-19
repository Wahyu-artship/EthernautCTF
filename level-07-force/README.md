# Level 07 - Force

## Vulnerability
The `Force` contract has no `payable` functions, no `receive()`, and no `fallback()` - meaning it has no normal way to accept ETH. Any regular transfer to it would revert.

## Exploit steps
1. Deploy an attacker contract with some ETH balance (funded via a payable constructor).
2. Call `selfdestruct(target)` on the attacker contract. `selfdestruct` forcibly sends the contract's remaining balance to the target address, bypassing all normal ETH-receiving checks (no receive/fallback/payable function required on the recipient).

## Instance
- Instance address: 0x38f43e6F0B1682DE08792Fc4fa6f77EF96f73ea7
- Attack contract: 0xB6490bAb1c7d802aD2Ae04Feb6651E19B2a770BC
- Network: Sepolia
