# Level 11 - Elevator

## Vulnerability
`goTo()` calls `building.isLastFloor(_floor)` twice - once in the `if` condition, once again to set `top`. Since `building` is cast from `msg.sender` (the caller itself), and `isLastFloor` is not declared `view`, an attacker can implement `Building` with a function that returns a different value each call by mutating state between invocations.

## Exploit steps
1. Deploy an attacker contract implementing `isLastFloor()` with a toggling boolean state variable.
2. Return the OLD value first, then flip the state - so the first call (in the `if` check) returns `false` (passing the condition), and the second call returns `true` (setting `top = true`).
3. Call `Elevator.goTo()` from the attacker contract to trigger this sequence.

## Instance
- Instance address: 0x3D00FbbE1e296C8e59A5931B97889F1338805fB7
- Attack contract: 0x3466bd7EE9c665b49a1C4f126b123E5A9385E323
- Network: Sepolia
