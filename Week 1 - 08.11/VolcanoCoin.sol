// SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.8.0;

// test contract in Remix IDE
contract VolcanoCoin {
    uint supply = 10000;
    address private owner;
    event Supply_set(uint);
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier isOwner {
        if (msg.sender == owner) {
            _;
        }
    }
    
    function getSupply() public view returns (uint) {
        return supply;
    }
    
    function addSupply() public isOwner {
        supply = supply + 1000;
        emit Supply_set(supply);
    }
}