# shared_wallet.3.0

## About

**We’ll create a shared wallet that will hold funds in ETH and that can be funded by an admin. The admin will provide an allowance to a few users who can then spend it as per their allowance and till a certain time limit set by the admin.

The entire flow will work as follows :

- Admin deploys a smart contract that acts as a shared wallet 
- Admin funds the wallet with some ETH, this will be the wallet’s total balance
- Admin authorises certain wallet addresses to spend a certain amount of ETH from the wallet within a certain time limit
- Finally, the users can spend the ETH within their allowance and time limit, as set by the admin.**

_Please note that it is important to update the state first before making the transfers i.e. updating the user’s allowance in this case before transferring the money. This is useful to prevent attacks like reentrancy that we’ll learn about in the module on smart contract security._

### Getting started

-------------------

@0xJonaseb11
