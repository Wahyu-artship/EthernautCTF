# Level 12 - Privacy

## Vulnerability
Same core lesson as Level 08 (Vault) - `private` only restricts access at the Solidity language level, not at the blockchain data level. This level adds complexity via storage packing: `flattening`, `denomination`, and `awkwardness` are packed together into a single slot since they fit within 32 bytes, while the `bytes32[3] data` array occupies its own dedicated slots (one per element), unaffected by packing rules that apply to scalar variables.

## Exploit steps
1. Calculate storage slots: `locked` (slot 0), `ID` (slot 1, needs full 32 bytes), `flattening + denomination + awkwardness` (packed into slot 2), `data[0]` (slot 3), `data[1]` (slot 4), `data[2]` (slot 5).
2. Read slot 5 directly using `cast storage <address> 5`, bypassing the `private` keyword.
3. `unlock()` expects a `bytes16` key, and converting `bytes32` to `bytes16` in Solidity truncates to the first 16 bytes. Take the first 32 hex characters of the value read from storage.
4. Call `unlock()` with that truncated value.

## Instance
- Network: Sepolia
