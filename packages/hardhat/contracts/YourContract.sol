pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

contract YourContract {

    mapping(address => uint256) public balance;

    constructor() payable {
    }

    function deposit (uint256 amount) public {
      balance[msg.sender] = balance[msg.sender] + amount;
    }

    function checkBalance () public view returns (uint256) {
      return balance[msg.sender];
    }
}
