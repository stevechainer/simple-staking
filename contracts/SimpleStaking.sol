// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleStaking {
    mapping(address => uint256) public stakes;

    function stake() public payable {
        require(msg.value > 0, "Cannot stake 0");
        stakes[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint256 balance = stakes[msg.sender];
        require(balance > 0, "No balance to withdraw");

        stakes[msg.sender] = 0;
        payable(msg.sender).transfer(balance);
    }

    function getBalance() public view returns (uint256) {
        return stakes[msg.sender];
    }
}
