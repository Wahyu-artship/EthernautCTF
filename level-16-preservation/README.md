# Level 16 - Preservation

## Vulnerability
Building on Level 06's storage collision lesson, but two-step. `Preservation`'s storage layout is `[timeZone1Library, timeZone2Library, owner, storedTime]` (slots 0-3). `LibraryContract`'s `storedTime` is at slot 0. When `setFirstTime()` delegatecalls to `LibraryContract.setTime()`, the write lands on `Preservation`'s slot 0 - overwriting `timeZone1Library`, not the intended `storedTime`.

## Exploit steps
1. Deploy an attacker contract with the SAME storage layout as `Preservation` up to the third slot (two dummy address variables, then the target variable), so its `setTime()` writes to whatever occupies slot 2 in the caller's storage.
2. Call `setFirstTime()` with the attacker contract's address (as a uint256) - this overwrites `timeZone1Library` (slot 0) to point at the attacker contract instead of the original library.
3. Call `setFirstTime()` again - this now delegatecalls into the attacker's `setTime()`, which writes to slot 2 (owner) instead of storedTime, transferring ownership to any address the attacker chooses.

## Instance
- Instance address: 0x3294d94815b9443587244d69770e30591261B473
- Attack contract: 0xab1e42e6B63713eaf00a95B743121EBE69A6A9B2
- Network: Sepolia
