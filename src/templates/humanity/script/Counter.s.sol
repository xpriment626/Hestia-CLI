// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/forge-std/src/Script.sol";

import { HumanMessage } from "../src/HumanMessage.sol";

contract ContractScript is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();
        new HumanMessage();
    }
}
