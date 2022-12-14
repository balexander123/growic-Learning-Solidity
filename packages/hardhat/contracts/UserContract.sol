pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

contract UserContract {
    constructor() payable {
        owner = msg.sender;
    }

    address owner;

    uint256 constant Fee = 1;

    // user record type
    struct User {
        string name;
        uint256 age;
    }

    // user records mapping
    mapping(address => User) public user;

    event ProfileUpdated(address user);

    // update user record details of message sender in user mapping
    function setUserDetails(string calldata name, uint256 age) public {
        user[msg.sender].name = name;
        user[msg.sender].age = age;
        emit ProfileUpdated(msg.sender);
    }

    // read user record from mapping
    function getUserDetail() public view returns (User memory) {
        return user[msg.sender];
    }

    // user account balance mapping
    mapping(address => uint256) public balance;

    event FundsDeposited(address user, uint256 amount);

    // deposit amount for message sender
    function deposit() public payable sufficientBalance(msg.value) {
        balance[msg.sender] = balance[msg.sender] + msg.value;
        // tranfers funds to contract owner
        payable(owner).transfer(msg.value);
        emit FundsDeposited(msg.sender, msg.value);
    }

    // require a previous deposit
    modifier sufficientBalance(uint256 _amount) {
        require(msg.sender.balance > _amount, "Insufficient balance");
        _;
    }

    // read balance of message sender account
    function checkBalance() public view returns (uint256) {
        return balance[msg.sender];
    }

    // allow owner to withdraw funds
    function withdraw() public payable onlyOwner {
        address payable to = payable(msg.sender);
        to.transfer(balance[msg.sender]);
        balance[msg.sender] = 0;
    }

    // require only owner 
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // require a previous deposit
    modifier validBalance() {
        require(balance[msg.sender] > 0, "Invalid balance");
        _;
    }

    // require sender to cover fees
    modifier validAmount(uint256 _amount) {
        require(_amount > Fee, "Amount too small");
        _;
    }

    // add amount to existing deposit and cover fee
    function addFund(uint256 _amount)
        public
        payable
        validBalance
        validAmount(_amount)
    {
        balance[msg.sender] = balance[msg.sender] + _amount;
        payable(owner).transfer(_amount);
    }

    // fallback function to receive Ether
    fallback() external payable {
        // send / transfer (forwards 2300 gas to this fallback function)
        // call (forwards all of the gas)
    }
}