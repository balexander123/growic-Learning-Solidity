pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

contract UserContract {
    constructor() payable {}

    struct User {
        string name;
        uint256 age;
    }

    mapping(address => User) public user;

    function setUserDetails(string calldata name, uint256 age) public {
        user[msg.sender].name = name;
        user[msg.sender].age = age;
    }

    function getUserDetail() public view returns (User memory) {
        return user[msg.sender];
    }

    mapping(address => uint256) public balance;

    function deposit(uint256 amount) public {
        balance[msg.sender] = balance[msg.sender] + amount;
    }

    function checkBalance() public view returns (uint256) {
        return balance[msg.sender];
    }

}
