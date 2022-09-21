// Contracts/Faucet.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

interface IERC20 {
    function transfer(address to, uint256 amount) external view returns (bool);
    function balanceoF(address account) external view returns (uint256);
    event Transfer(address indexed from, address indexed to, uint256 value);
}

contract Faucet{

    address payable owner;
    IERC20 public token;
    uint256 public withdrawalAmount = 50 * (10**18);

    mapping(address => uint256) nextAccessTime;
    uint256 public locktIme = 1 minutes;
    event Deposit(address indexed from, uint256 indexed amount);
    event Withdrawal(address indexed to, uint256 indexed amount);

    constructor(address tokenAddress) payable{
        token = IERC20(tokenAddress);
        owner = payable(msg.sender);
    }

    function requesttoken() public {
        require(msg.sender != address(0), "Request must not originate from a zero account");
        require(token.balanceoF(address(this)) >= withdrawalAmount, "Insufficient balance in faucet for withdrawal");
        require(block.timestamp >= nextAccessTime[msg.sender], "Insufficient time elapsed since last withdrawal");

        nextAccessTime[msg.sender] = block.timestamp + locktIme;
        token.transfer(msg.sender, withdrawalAmount);
    }

    receive() external payable{
        emit Deposit(msg.sender, msg.value);
    }

    function getBalance() external view returns (uint256){
        return token.balanceoF(address(this));
    }

    function setwithdrawalAmount(uint256 amount) public onlyOwner{
        withdrawalAmount = amount * (10**18);
    }

    function setBlockTime(uint256 amount) public onlyOwner{
        locktIme = amount * 1 minutes;
    }

    function withdrawal() external onlyOwner{
        emit Withdrawal(msg.sender, token.balanceoF(address(this)));
        token.transfer(msg.sender, token.balanceoF(address(this)));
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Only owner can execute this function");
        _;
    }

}