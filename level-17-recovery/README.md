# Level 17 - Recovery

## Vulnerability
Not a code vulnerability - this level tests understanding of how contract addresses are computed. When a contract deploys another contract via `new`, the resulting address is deterministic: it's derived from `keccak256(rlp([deployer_address, deployer_nonce]))`, truncated to the last 20 bytes. The deployed contract's address was never recorded, but it's fully recoverable from public data alone.

## Exploit steps
1. Since `Recovery.generateToken()` was called exactly once, the deployer's nonce at that point was 1 (contract creation nonces start at 1, not 0).
2. Compute the deployed `SimpleToken` address using `cast compute-address <deployer> --nonce 1`.
3. Call `destroy(address)` on the recovered contract to `selfdestruct` it and forcibly send its balance to any address.

## Instance
- Recovery instance: 0x25Af1609Af993813Cd55288936f23dea555Bf991
- Recovered SimpleToken address: 0xd509e5Fb745674387285eEaDE6eD6f2c0C187b81
- Network: Sepolia
