# Level 10 - Re-entrancy

## Vulnerability
`withdraw()` sends ETH to the caller via `.call{value: _amount}("")` BEFORE decrementing the caller's balance. Since `.call()` forwards execution control to the recipient, if the recipient is a contract with a `receive()` function, that function executes before the balance is ever decremented - allowing the caller to re-enter `withdraw()` repeatedly while the balance check still passes, draining the contract before the balance update ever happens.

This is the same vulnerability class behind the 2016 DAO hack, one of the most significant exploits in Ethereum's history, which led to the ETH/ETC chain split.

## Exploit steps
1. Deploy an attacker contract with a `receive()` function that recursively calls `withdraw()` again as long as the target still has balance.
2. Donate a small amount to pass the initial balance check, then call `withdraw()` once to kick off the recursive chain.
3. Each recursive call drains more ETH before the balance is ever updated, fully draining the contract.

## Instance
- Instance address: 0x5ffD7b0fe94F9fD216118500662b5A3b21121505
- Attack contract: 0xCDe398fE76D9fEC87E3Bc90c55743699B895B312
- Network: Sepolia
