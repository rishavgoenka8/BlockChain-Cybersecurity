// SPDX-License-Identifier: MIT
pragma solidity ^0.6.10;

contract PreventsOutofGas {
    address public owner;
    address[] investors;
    mapping(address => uint) public balances;

    constructor() public {
        owner = msg.sender;
    }

    function invest() external payable {
        investors.push(msg.sender);
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public {
        require(balances[msg.sender] >= _amount);

        balances[msg.sender] -= _amount;

        (bool sent, ) = msg.sender.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}