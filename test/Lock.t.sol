// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import "../src/Lock.sol";

contract LockTest is Test {
    Lock public lock;

    function setUp() public {
        // Setup with an unlock time in the future and the test contract as the owner
        uint unlockTime = block.timestamp + 1 days;
        lock = new Lock(address(this), unlockTime);
    }

    function test_SetName() public {
        // Set the name using the setName function
        string memory newName = "Test Lock";
        lock.setName(newName);

        // Retrieve the name from the contract
        string memory currentName = lock.name();

        // Assert that the name was set correctly
        assertEq(currentName, newName, "The name was not set correctly.");
    }
}
