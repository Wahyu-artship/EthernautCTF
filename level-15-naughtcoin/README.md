# Level 15 - Naught Coin

## Vulnerability
The contract overrides `transfer()` to lock the player's tokens for 10 years, but it's a standard OpenZeppelin ERC20, which also exposes `approve()` and `transferFrom()` - neither of which is overridden or locked. ERC20 has two paths to move tokens (direct `transfer()`, or `approve()` + `transferFrom()`), and locking only one path leaves the other completely open.

## Exploit steps
1. As the player, call `approve(player, balance)` to approve yourself to spend your own full balance.
2. Call `transferFrom(player, anyOtherAddress, balance)` - since `msg.sender` here is the player (who just approved themselves), this succeeds and moves all tokens out, completely bypassing the 10-year lock on `transfer()`.

## Instance
- Network: Sepolia
