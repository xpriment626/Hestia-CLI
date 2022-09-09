// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/forge-std/src/Test.sol";
import { HumanMessage } from "../src/HumanMessage.sol";

error Error__NotHuman();

contract ContractTest is Test {

    /**
     * @dev add your key to .env.example and follow the same setup 
     * process for any other fork you'd like to add.
     */
    string MAINNET_RPC_URL = vm.envString("ALCHEMY_MAINNET_URL");
    uint256 ethMainnetFork = vm.createFork(MAINNET_RPC_URL);

    HumanMessage instance;
    // Random registered address on Proof of Humanity
    address alice = 0xE5cea75afEF885CB03FFf15888E8A2C844FB71B0;
    // Random address not registered on Proof of Humanity
    address robot = 0x48936cf56a6cc74535C72430f22F54Da12Ae058E;

    /**
     * @dev make sure to set your desired fork
     * before deplpying the contract instance. 
    */
    function setUp() public {
        vm.selectFork(ethMainnetFork);
        instance = new HumanMessage();
    }

    function testSetByHuman() public {
        vm.selectFork(ethMainnetFork);
        assertEq(vm.activeFork(), ethMainnetFork);
        vm.prank(alice);
        instance.setMessage("Joe");

        string memory expected = instance.message();
        assertEq(expected, "Joe");
    }

    function testSetByBot() public {
        vm.selectFork(ethMainnetFork);
        vm.prank(robot);
        vm.expectRevert(Error__NotHuman.selector);
        instance.setMessage("Mama");
    }
}
