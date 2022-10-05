// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

contract ERC20{
    uint256 private total_supply_;
    mapping(address=> uint256)private  balances;
    mapping(address=>mapping(address=>uint256))private  allowed;
    string private name;
    string private symbol;

    event Transfer(address owner, address receiver, uint256 numTokens);
    event Approval(address owner, address delegate, uint256 numTokens);

    constructor(uint256 total, string memory _name, string memory _symbol){
        total_supply_ = total;
        balances[msg.sender] = total_supply_;
        name = _name;
        symbol = _symbol;
    }

    function get_name() public view returns(string memory){
        return name;
    }

    function get_symbol() public view returns(string memory){
        return symbol;
    }

    function total_supply() public view returns(uint256){
        return total_supply_;
    }

    function balance_of(address owner) public view returns(uint256){
        return balances[owner];
    }

    function transfer(address receiver, uint256 numTokens) public returns (bool){
        require(balances[msg.sender]>=numTokens);
        balances[receiver]+= numTokens;
        balances[msg.sender]-=numTokens;
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    function approve(address delegate, uint numTokens) public returns (bool){
        allowed[msg.sender][delegate] += numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance(address owner, address delegate) public view returns(uint256){
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint256 numTokens) public returns (bool){
        require(balances[owner]>=numTokens);
        require(allowed[owner][buyer]>=numTokens);
        balances[owner] -= numTokens;
        allowed[owner][buyer] -= numTokens;
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
}
