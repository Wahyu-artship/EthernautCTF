# Level 01 - Fallback

## Vulnerability
The contract has two paths to become `owner`:
1. `contribute()` - requires contributions to exceed the owner's (1000 ether), impractical since each call is capped at < 0.001 ether.
2. `receive()` - the fallback function only requires `contributions[msg.sender] > 0` and any ETH sent directly to the contract. No comparison against the current owner's contribution is needed.

## Exploit steps
1. Call `contribute()` with a small amount (e.g. 0.0005 ether) so `contributions[msg.sender] > 0`.
2. Send ETH directly to the contract address (triggers `receive()`), which sets `owner = msg.sender`.
3. Call `withdraw()` as the new owner to drain the contract balance to 0.

## Instance
- Level address: 0x3c34A342b2aF5e885FcaA3800dB5B205fEfa3ffB
- Instance address: 0x17300c55238578929D0bF7C5Ad2d26a853847Fbb
- Network: Sepolia
