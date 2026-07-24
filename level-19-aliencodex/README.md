# Level 19 - Alien Codex

## Vulnerability
Solidity ^0.5.0 has no automatic underflow protection. `retract()` decrements `codex.length` without checking if it's already 0. When called on an empty array, this underflows the length to `2^256 - 1` - effectively making the array "span" the entire storage address space of the contract, since dynamic array data location wraps around modulo `2^256`.

## Storage layout (note: owner and contact are packed into slot 0)

Slot 0: owner (address) + contact (bool) - packed together, 21 bytes total
Slot 1: codex.length


Array data for `codex` starts at `keccak256(1)` and extends sequentially. With an underflowed length, any storage slot in the contract (including slot 0, where `owner` lives) becomes reachable via `revise()`.

## Exploit steps
1. Call `makeContact()` to satisfy the `contacted` modifier.
2. Call `retract()` on the empty array to underflow its length to `2^256 - 1`.
3. Compute the index `i` such that `keccak256(1) + i ≡ 0 (mod 2^256)`, i.e. `i = 2^256 - uint256(keccak256(abi.encode(uint256(1))))`.
4. Call `revise(i, ownerAddressAsBytes32)` to overwrite slot 0 directly, taking ownership.

Note: an earlier attempt miscalculated the storage slot for `codex.length` as slot 2, assuming `owner` and `contact` each occupied their own slot. Reading raw storage with `cast storage` revealed they were packed into slot 0 together, and `codex.length` was actually at slot 1.

## Instance
- Instance address: 0x120cAD5f23f9C290ae7098ED90A403d5Ba407488
- Network: Sepolia
