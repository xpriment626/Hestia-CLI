// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
interface IHuman {
    function isRegistered(address _submissionID) external view returns (bool);
}