// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

contract InterestBank {
    mapping(address=>uint256) balance;
    mapping(address=>uint256) loanTaken;

    function deposit() public payable{
        balance[msg.sender] += msg.value;
        balance[address(this)] += msg.value;
    }

    function withdraw() public payable {
        payable(msg.sender).transfer(balance[msg.sender]+balance[msg.sender]*2/100);
        balance[address(this)] -= balance[msg.sender];
        balance[msg.sender] = 0;
    } 

    function takeLoanInWei(uint256 _amount) public payable {
        payable(msg.sender).transfer(_amount);
        loanTaken[msg.sender] += _amount + _amount*2/100;
        balance[address(this)] -= _amount;
        loanTaken[address(this)] += _amount + _amount*2/100;
    }

    function returnLoan() public payable {
        balance[address(this)] += msg.value;
        loanTaken[address(this)] -=  msg.value;
        loanTaken[msg.sender] = 0;
    }

    function getBalance(address _accountBalance) public view returns(uint256){
        return _accountBalance.balance;
    }
    function getLoanTaken(address _accountLoan) public view returns(uint256){
        return loanTaken[_accountLoan];
    }
}
