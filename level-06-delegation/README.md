# Level 06 - Delegation

## Vulnerability
`Delegation`'s fallback function forwards any unmatched calldata to `Delegate` via `delegatecall`. `delegatecall` executes the target's code but preserves the caller's storage context and `msg.sender`. Since both contracts declare `owner` as their first storage variable (slot 0), calling `Delegate.pwn()` through `Delegation`'s fallback writes to `Delegation`'s slot 0 - overwriting `Delegation.owner`, not `Delegate.owner`.

## Exploit steps
1. Send a transaction to the `Delegation` instance with calldata matching the `pwn()` function selector (no matching function exists directly on `Delegation`, so this triggers the fallback).
2. The fallback delegatecalls to `Delegate.pwn()`, which sets `owner = msg.sender` - but because of the shared storage layout, this updates `Delegation`'s owner to the caller's address.

## Instance
- Network: Sepolia
