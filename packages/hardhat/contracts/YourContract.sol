pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

import "@openzeppelin/contracts/access/Ownable.sol";
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract is Ownable {

    mapping(address => uint256) public accounts;

    constructor() payable {
    }

    function deposit (uint256 amount) public {
      accounts[msg.sender] = accounts[msg.sender] + amount;
      console.log("deposit >> account balance: ", accounts[msg.sender]);
    }

    function checkBalance () public view returns (uint256) {
      console.log("checkBalance >> account balance: ", accounts[msg.sender]);
      return accounts[msg.sender];
    }

    // to support receiving ETH by default
    receive() external payable {}

    fallback() external payable {}
}
