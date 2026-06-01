// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CryptoArcPayment {
    address public owner;
    uint256 public premiumPrice = 0.01 ether; // Price for premium membership (0.01 Test ETH)

    // Events to track payments and price updates
    event PaymentReceived(address indexed user, uint256 amount, uint256 timestamp);
    event PriceChanged(uint256 oldPrice, uint256 newPrice);

    // Mapping to store users who have premium access
    mapping(address => bool) public hasPremiumAccess;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender; // The deployer becomes the owner of the contract
    }

    // Function for users to buy premium membership
    function buyPremium() external payable {
        require(!hasPremiumAccess[msg.sender], "You already have premium access!");
        require(msg.value == premiumPrice, "Incorrect payment amount. Please send the exact price.");

        // Grant premium access to the user
        hasPremiumAccess[msg.sender] = true;

        // Trigger event for the backend to listen
        emit PaymentReceived(msg.sender, msg.value, block.timestamp);
    }

    // Function for the owner to change the premium price
    function setPremiumPrice(uint256 _newPrice) external onlyOwner {
        emit PriceChanged(premiumPrice, _newPrice);
        premiumPrice = _newPrice;
    }

    // Function for the owner to withdraw funds from the contract
    function withdrawFunds() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds available to withdraw");
        
        (bool success, ) = payable(owner).call{value: balance}("");
        require(success, "Transfer failed");
    }

    // Function to check if a specific user has premium status
    function checkPremiumStatus(address _user) external view returns (bool) {
        return hasPremiumAccess[_user];
    }
}
