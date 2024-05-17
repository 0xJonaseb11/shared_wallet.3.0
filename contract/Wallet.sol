// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
 
contract Wallet {
  
   address public owner;
   mapping(address => User) public users;
 
  // state variables
   struct User {
       address userAddress;
       uint allowance;
       uint validity;
   }
 
  //events
  event AllowanceRenewed(address indexed user, uint allowance, uint timeLimit);
   event CoinsSpent(address indexed receiver, uint amount);
 
   modifier onlyOwner() {
       msg.sender == owner;
       _;
   }
 
   constructor() {
       owner = msg.sender;
   }
 
   receive() external payable onlyOwner {}

   // get wallet balance 
   function getWalletBalance() public view returns (uint) {
       return address(this).balance;
   }

    //renew allowance
    function renewAllowance(address _user, uint _allowance, uint _timeLimit) public onlyOwner {
       uint validity = block.timestamp + _timeLimit;
       users[_user] = User(_user, _allowance, validity);
       emit AllowanceRenewed(_user, _allowance, _timeLimit);
   }

   // Retrieve my allowance[msg.sender]
   function myAllowance() public view returns(uint) {
       return users[msg.sender].allowance;
   }
 
   // spend coins
   function spendCoins(address payable _receiver, uint _amount) public {
       User storage user = users[msg.sender];
   require(block.timestamp < user.validity, "Validity expired!!");
   require(_amount <= user.allowance, "Allowance not sufficient!!");
     
       user.allowance -= _amount;
       _receiver.transfer(_amount);
       emit CoinsSpent(_receiver, _amount);
   }
}