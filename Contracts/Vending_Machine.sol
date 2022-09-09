// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract VendingMachine {

    address public owner;
    mapping (address => uint) public donutbalances;

    constructor(){
        owner = msg.sender;
        donutbalances[address(this)] = 100;
    }

    function getVendingMachineBalance() public view  returns (uint) {
        return donutbalances[address(this)];
    }

    function restock(uint amount) public {
        require(msg.sender == owner, "Only the owner can restock...");
        donutbalances[address(this)] += amount;
    }

    function purchase(uint amount) public payable {
        require(msg.value >= amount * 2 ether, "You must pay 2 ether for donut.");
        require(donutbalances[address(this)] >= amount, "Not enough donut.");
        require(msg.sender != owner, "Owner cannot purchase a donut");

        donutbalances[address(this)] -= amount;
        donutbalances[msg.sender] += amount;
    }
}