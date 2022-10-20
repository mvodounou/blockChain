// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract BuyMeAcoffee {
    // Event to emit when a Memo is created
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    // Memo struct
    struct Memo{
        address from;
        uint256 timestamp;
        string name;
        string message;
    }
    // List of all memos received from friends
    Memo[] memos;

    // Address of contract deployer
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    /**
    * @dev buy a coffee for contract owner
    * @param _name name of the coffee buyer
    * @param _message a nice message from the buyer
    */

    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "can't buy coffee with 0 eth.");

        // Add memo to collection
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        // emit a log event when a memo is created
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    /**
    * @dev pull tips to contract owner
    */
    function withdrawTips() public { 
        require(owner.send(address(this).balance));
    }


    /**
    * @dev pull all memos
    */
    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }
}