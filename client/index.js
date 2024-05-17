const { ethers } = require("ethers");

const contractAddress = "0x4a9C121080f6D9250Fc0143f41B595fD172E31bfD";

const connect = async() => {
    const provider = new ethers.web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const walletContract = new ethers.Contract(contractAddress, abi, signer);
    const accounts = await window.ethereum.request({
        method: "eth_requestAccounts"
    });
    const account = accounts[0];

    // get response from the client
    document.getElementById("wallet-address").textContent() = 
    account.substring(0, 5) + "..." + account.substring(37, 42);

    document.getElementById("pending-allowance").textContent() =
    await walletContract.myAllowance();

    document.getElementById("wallet-address").textContent() = 
    await walletContract.getWalletBalance();
}

connect();