// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

contract Lock {
    uint public unlockTime;
    address payable public owner;
    string public name;

    event Withdrawal(uint amount, uint when);

    constructor(address _owner, uint _unlockTime) payable {
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );

        unlockTime = _unlockTime;
        owner = payable(_owner);
    }

    function withdraw() public {
        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        require(msg.sender == owner, "You aren't the owner");

        emit Withdrawal(address(this).balance, block.timestamp);

        owner.transfer(address(this).balance);
    }

    function setName(string memory _name) external {
        if (bytes(name).length > 0) return;
        name = _name;
    }
}