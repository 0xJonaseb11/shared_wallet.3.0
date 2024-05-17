const { ethers } = require("ethers");
const abi = require("./abi")

const contractAddress = "0x4a9C121080f6D9250Fc0143f41B595fD172E31bfD";

const connect = async () => {
    try {
        if (!window.ethereum) {
            alert("MetaMask is not installed. Please install it to use this app.");
            return;
        }

        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const signer = provider.getSigner();
        const walletContract = new ethers.Contract(contractAddress, abi, signer);
        const accounts = await window.ethereum.request({
            method: "eth_requestAccounts"
        });
        const account = accounts[0];

        // Display the connected account address
        document.getElementById("wallet-address").textContent = 
            account.substring(0, 5) + "..." + account.substring(37, 42);

        // Display the pending allowance
        const allowance = await walletContract.myAllowance();
        document.getElementById("pending-allowance").textContent = allowance.toString();

        // Display the wallet balance
        const balance = await walletContract.getWalletBalance();
        document.getElementById("wallet-balance").textContent = balance.toString();
    } catch (error) {
        console.error("Error connecting to wallet:", error);
    }
};

window.connect = connect;
