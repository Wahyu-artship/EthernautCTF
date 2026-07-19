# Level 08 - Vault

## Vulnerability
The `password` variable is declared `private`, which only prevents other Solidity contracts from reading it through a generated getter function. It does NOT hide the value from the blockchain itself - all contract storage is public data, readable via raw storage slot queries regardless of Solidity visibility keywords.

## Exploit steps
1. Determine the storage slot: `locked` (bool) occupies slot 0; `password` (bytes32) occupies slot 1, since it needs the full 32 bytes and can't be packed with `locked`.
2. Read the raw storage slot directly using `cast storage <address> 1 --rpc-url <url>`, bypassing the `private` keyword entirely.
3. Call `unlock(bytes32)` with the exact value read from storage.

## Instance
- Network: Sepolia
