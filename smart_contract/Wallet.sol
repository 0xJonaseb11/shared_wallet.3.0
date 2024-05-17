// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Wallet {

    // state variables
    address public  owner;
    mapping (address => User) public users;

    struct Users {
        address userAddress;
        uint allowance;
        uint validity;
    }

    // emit events
    event AllowanceRenewed(address indexed user, uint allowance, uint timeLimit);
    event CoinsSpent(address indexed receiver, uint amount);

    modifier onlyOwner() {
        msg.sender == owner;
        _;
    }

    // initialize contract w/ owner
    constructor() {
        owner = msg.sender;
    }

    // receive assets
    receive() external payable onlyOwner{}

    // get wallet balance
    function getWalletBalance() public  view returns (uint) {
        return  address(this).balance;
    }

    // renew Allowance
    function renewAllowance(address _user, uint _allowance, uint _timeLimit) public onlyOwner {
        uint validity = block.timestamp + _timeLimit;
        users[_user] = User(_user, _allowance, _validity);

        // emit event to indicate renewal of allowance
        emit AllowanceRenewed(_user, _allowance, _timeLimit);
    }

    // Retrieve my allowance[msg.sender]
    function myAllowance() public  view returns (uint) {
        return users[msg.sender].allowance;
    }

    // Spend coins
    function spendCoins(address payable _receiver, uint _amount) public  {
        User storage user = users[msg.sender];

        require(block.timestamp < user.validity, "Validity expired");
        require(_amount <= user.allowance, "Allowance funds not sufficient!!");

        // do spend coins logic after above conditions meet
        user.allowance -= _amount;
        _receiver.transfer(_amount);

        // trigger event for coins spent
        emit CoinsSpent(_amount, _receiver);
    }
}