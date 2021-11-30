// SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.8.0;

// test contract in Remix IDE
contract VolcanoCoin {
    uint supply = 10000;
    address private owner;
    event Supply_set(uint);
    event TransferSuccess(uint indexed, address); 

    mapping(address => uint) public balance;
    mapping(address => Payment[]) public paymentsReference;

    struct Payment {
        uint amount;
        address recipient;
    }
    
    constructor() {
        owner = msg.sender;
        balance[owner] = supply;
        supply = 0;
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

    function transfer(uint _amount, address _recipient) public {
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        // do transaction
        balance[msg.sender] -= _amount;
        balance[_recipient] += _amount;

        // save in paymentsReference
        paymentsReference[msg.sender].push(Payment({amount: _amount, recipient: _recipient}));
        emit TransferSuccess(_amount, _recipient);
    }

    function getPayments(address _user) public view returns (Payment[] memory) {
        return paymentsReference[_user];
    }
}