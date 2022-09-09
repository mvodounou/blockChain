// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract RandomNumber is VRFConsumerBase{
    byte32 internal keyHash;
    uint internal fee;
    uint public randomResult;

    constructor() 
        VRFConsumerBase 
        (
            0x2bce784e69d2Ff36c71edcB9F88358dB0DfB55b4, // VRF Coordinator
            0x326C977E6efc84E512bB9C30f76E30c160eD06FB  // LINK Token
        ){
        keyHash = 0x0476f9a745b61ea5c0ab224d3a6e4c99f0b02fce4da01143a4f70aa80ae76e8a;
        fee = 0.1 * 10 ** 18; // 0.1 LINK (Varies by network)
        }
    

    function getRandomNumber() public returns (byte32 requestId){
        require(LINK.balanceOf(address(this)) >= fee, "not enough LINK in contract");
        return requestRandomness(keyHash, fee);
    }

    function fulfillRandomness(byte32 requestId, uint randomness) internal override {
        randomResult = randomness.mod(10).add(1);
    }
}