# Level 03 - Coin Flip

## Vulnerability
The contract uses `blockhash(block.number - 1)` as a source of "randomness". This value is public on-chain data, readable by anyone before they submit their own transaction. Since the coin flip result is purely a deterministic calculation from this public value, an attacker can compute the outcome in advance and guarantee a correct guess.

## Exploit steps
1. Deploy an attacker contract that replicates the exact same blockhash-based calculation inside a single transaction, then calls `flip()` with the guaranteed correct guess.
2. Because both the calculation and the call happen atomically in the same transaction/block, the guess is always correct.
3. Repeat 10 times (one call per block, since the contract blocks repeat calls within the same block) to reach `consecutiveWins == 10`.

## Instance
- Instance address: 0x4551F370BB9B668F5B98Be2b75703839a2f5a20c
- Attack contract: 0xA754BA589ab4a9f35dcA9aCD1f5e602884E17bF1
- Network: Sepolia
