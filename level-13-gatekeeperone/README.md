# Level 13 - Gatekeeper One

## Vulnerability
Three combined gates, each requiring a different bypass technique:

- **Gate One**: `require(msg.sender != tx.origin)` - requires calling through an intermediary contract (opposite condition from Level 04 Telephone, same underlying mechanism).
- **Gate Two**: `require(gasleft() % 8191 == 0)` - requires the exact remaining gas at that point to be a multiple of 8191. This can't be precisely calculated externally due to compiler/EVM version-specific overhead, so it's solved by brute-forcing a range of gas values in a loop.
- **Gate Three**: Bit manipulation on a `bytes8` key. The key must have its lowest 16 bits match the lowest 16 bits of `tx.origin`, its next 16 bits (16-31) be zero, and at least one bit set somewhere in the upper 32 bits (32-63).

## Exploit steps
1. Deploy an attacker contract (satisfies Gate One by acting as the intermediary).
2. Construct the gate key: `bytes8(uint64(uint160(tx.origin)) & 0xFFFFFFFF0000FFFF | 0x100000000)` - masks bits 16-31 to zero while preserving bits 0-15 (player address) and setting bit 32 to guarantee the upper half isn't all zero.
3. Loop through a range of gas values in the attacker contract, calling `enter()` with `{gas: X}` for each, until one lands on a multiple of 8191 and succeeds (Gate Two).

## Instance
- Instance address: 0x439e08C61A4AE02ec710E1D10561E5B67a113Fa4
- Attack contract: 0x4348cb96d49716e918f32e8a53A10F197bCa25BF
- Network: Sepolia
