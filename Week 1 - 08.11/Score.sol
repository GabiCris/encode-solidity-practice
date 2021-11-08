pragma solidity >=0.7.0 <0.9.0;

// test contract in Remix IDE
contract Score {
    uint score;
    address private owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier isOwner {
        if (msg.sender == owner) {
            _;
        }
    }
    
    function getScore() public view returns (uint) {
        return score;
    }
    
    function setScore(uint _newScore) public isOwner {
        score = _newScore;
    }
}