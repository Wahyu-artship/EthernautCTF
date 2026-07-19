# Level 09 - King

## Vulnerability
The contract lets anyone become the new "king" by sending more ETH than the current prize, and refunds the previous king via `.transfer()`. If the current king is a contract with no `receive()`/`fallback()`, that refund will always fail, causing the entire transaction to revert - permanently blocking anyone from ever becoming king again.

## Exploit steps
1. Deploy an attacker contract with no `receive()`/`fallback()` function.
2. Send enough ETH from that contract (via its constructor) to exceed the current prize and become king.
3. From this point on, any attempt to dethrone the attacker fails, because the required refund to the attacker contract always reverts.

## Instance
- Instance address: 0x967850dDCde30e5b30b904cF2093574350A10749
- Attack contract: 0x2C74e0e190c3120B492EE81bA35d970fad51A27C
- Network: Sepolia
