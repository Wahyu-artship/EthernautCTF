# Level 04 - Telephone

## Vulnerability
`changeOwner()` only updates the owner if `tx.origin != msg.sender`. When called directly from an EOA (wallet), `tx.origin` and `msg.sender` are identical, so the condition fails and nothing changes. But if the call is routed through an intermediary contract, `tx.origin` remains the original wallet while `msg.sender` becomes the intermediary contract's address - making the two values different and satisfying the condition.

## Exploit steps
1. Deploy an attacker contract with a function that calls `Telephone.changeOwner(desired_address)`.
2. Call that function from your wallet. Since the call to `changeOwner` now goes through the attacker contract (not directly from the wallet), `tx.origin` (wallet) != `msg.sender` (attacker contract), and ownership transfers successfully.

## Instance
- Instance address: 0x738af61108ac59b0a7F4Ce6D182Fb0073Ca24A07
- Attack contract: 0xD499e6Ef47136EB744861CE470427B31DAfeB9e0
- Network: Sepolia
