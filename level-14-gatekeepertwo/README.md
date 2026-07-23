# Level 14 - Gatekeeper Two

## Vulnerability
Three gates:
- **Gate One**: `msg.sender != tx.origin` - requires an intermediary contract.
- **Gate Two**: `extcodesize(caller()) == 0` - normally a contract has non-zero code size, but during contract construction (inside the constructor), the contract's own bytecode hasn't been written to the chain yet, so `extcodesize(address(this))` returns 0 at that point.
- **Gate Three**: XOR-based key check. `_gateKey` must equal `keccak256(abi.encodePacked(msg.sender)) XOR type(uint64).max` - a straightforward algebraic derivation from XOR's self-canceling property.

## Exploit steps
1. Deploy an attacker contract whose entire attack logic runs inside its own constructor - this satisfies Gate One (msg.sender is the contract, not tx.origin) and Gate Two (extcodesize is still 0 during construction) simultaneously.
2. Compute the gate key as the bitwise complement (XOR with max uint64) of `keccak256(abi.encodePacked(address(this)))`.
3. Call `enter()` with that key from within the constructor.

## Instance
- Instance address: 0xE81409bf4475A16be8d54efDC3a1252489389d07
- Attack contract: 0x4765Dac0E96Cc875c42198732E220cC6D8048160
- Network: Sepolia
