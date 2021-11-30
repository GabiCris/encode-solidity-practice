// SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// test contract in Remix IDE
contract VolcanoCoin is ERC20, Ownable {
    uint supply = 10000;
    event Supply_set(uint);
    event TransferSuccess(uint indexed, address); 
    mapping(address => Payment[]) public paymentsReference;

    struct Payment {
        uint amount;
        address recipient;
    }
    
    constructor() ERC20("Volcano", "VOL"){
        _mint(msg.sender, supply);
    }
    
    function getSupply() public view returns (uint) {
        return supply;
    }
    
    function addSupply() public onlyOwner {
        supply = supply + 1000;
        emit Supply_set(supply);
    }

    function transfer(uint _amount, address _recipient) public {
        // save in paymentsReference
        paymentsReference[msg.sender].push(Payment({amount: _amount, recipient: _recipient}));
        emit TransferSuccess(_amount, _recipient);
    }

    function getPayments(address _user) public view returns (Payment[] memory) {
        return paymentsReference[_user];
    }

    function mintTokensOwner(uint _supply) public onlyOwner {
        _mint(msg.sender, _supply);
    }
}