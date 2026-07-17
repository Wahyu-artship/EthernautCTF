# Level 02 - Fallout

## Vulnerability
Before Solidity 0.5.0, constructors were defined as functions with the exact same name as the contract. This contract is named `Fallout`, but the intended constructor is misspelled as `Fal1out()` (with a digit "1" instead of the second "l"). Because the name doesn't match exactly, Solidity does not treat it as a constructor - it becomes a regular public payable function that anyone can call at any time, not just during deployment.

## Exploit steps
1. Call `Fal1out()` directly - this sets `owner = msg.sender` for whoever calls it, since it's just a normal function, not a real constructor.
2. Call `collectAllocations()` as the new owner to drain the contract balance.

## Instance
- Network: Sepolia
