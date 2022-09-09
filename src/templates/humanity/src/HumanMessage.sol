// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { IHuman } from "./interfaces/IHuman.sol";

error Error__NotHuman();
contract HumanMessage {

    /** @dev Proof of Humanity address on Ethereum Mainnet */
    IHuman public human = IHuman(0xC5E9dDebb09Cd64DfaCab4011A0D5cEDaf7c9BDb);

    string public message;

    /** @dev check if an address is registered by calling isRegistered */
    modifier onlyHuman() {
        bool registered = human.isRegistered(msg.sender);
        if (!registered) {
            revert Error__NotHuman();
        }
        _;
    }

    function setMessage(string calldata newMessage) external onlyHuman {
        message = newMessage;
    }
}