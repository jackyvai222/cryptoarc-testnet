# CryptoArc Testnet - Payment Smart Contract

This repository contains the CryptoArcPayment smart contract, designed to handle premium membership payments on the Ethereum testnet. It allows users to purchase premium access by paying a fixed amount of test ETH, while providing the contract owner with tools to manage pricing and withdraw funds.

## 📋 Features

- **Premium Access Purchase:** Users can pay a fixed fee (0.01 ether by default) to instantly unlock premium status.
- **Dynamic Pricing:** The contract owner can update the premium membership price at any time.
- **Secure Withdrawals:** The contract owner can securely withdraw accumulated funds from the contract.
- **Status Tracking:** Public mapping and view functions to easily verify if an address has premium access.
- **Event Logging:** Emits explicit events (`PaymentReceived` and `PriceChanged`) for seamless backend and frontend integration.

## 🛠️ Contract Details

- **Solidity Version:** ^0.8.20
- **License:** MIT
- **Key State Variables:**
  - `owner`: The address that deployed the contract (has exclusive administrative rights).
  - `premiumPrice`: The current cost of the premium membership (initialized to 0.01 ether).
  - `hasPremiumAccess`: A mapping tracking the premium status of user addresses.

## 🚀 Functions

### User Functions

#### buyPremium()
- **Type:** external payable
- **Description:** Allows a user to purchase premium access.
- **Requirements:**
  - The user must not already have premium access.
  - The exact `premiumPrice` must be sent with the transaction.

#### checkPremiumStatus(address _user)
- **Type:** external view
- **Returns:** bool
- **Description:** Returns `true` if the specified address has premium access, otherwise `false`.

### Owner Functions (Requires `onlyOwner`)

#### setPremiumPrice(uint256 _newPrice)
- **Type:** external
- **Description:** Updates the cost of the premium membership.

#### withdrawFunds()
- **Type:** external
- **Description:** Transfers the entire contract balance to the owner's wallet.

## 🔔 Events

- `PaymentReceived(address indexed user, uint256 amount, uint256 timestamp)`: Emitted whenever a user successfully purchases premium access.
- `PriceChanged(uint256 oldPrice, uint256 newPrice)`: Emitted when the contract owner updates the premium membership price.

## 🔗 Deployed Contract Address
- **CryptoArcPayment:** 0xE8E6280bEff6F57223f26Ad6cB33352E920CbdB7

---

## 📦 Deployment & Testing

1. **Compile:** Use Solidity compiler version `0.8.20` or higher in Remix IDE.
2. **Deploy:** Select the Injected Provider (MetaMask) and ensure you are connected to the Arc Network Testnet before hitting deploy.
