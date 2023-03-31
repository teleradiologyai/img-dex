MedicalImageExchange
MedicalImageExchange is a smart contract for exchanging medical images using TeleradiologyAI and TRAI coin. This contract enables users to create non-fungible tokens (NFTs) representing different types of medical images, including XR, MRI, and CT scans. These NFTs can then be exchanged among users in exchange for TRAI coins.

Getting Started
To use the MedicalImageExchange smart contract, you will need to have a basic understanding of smart contracts and the Ethereum blockchain. You will also need to have a wallet that supports the Ethereum network, such as MetaMask.

Prerequisites
Solidity v0.8.0 or higher
Truffle v5.4.2 or higher
OpenZeppelin v4.4.0 or higher
Installing
To install the necessary dependencies, run the following command in your terminal:

Copy code
npm install
Running the tests
To run the tests for the MedicalImageExchange smart contract, run the following command in your terminal:

bash
Copy code
truffle test
Usage
To use the MedicalImageExchange smart contract, you will need to deploy it to the Ethereum network using a tool such as Truffle. Once the contract is deployed, you can interact with it using a wallet that supports the Ethereum network, such as MetaMask.

Functions
The MedicalImageExchange smart contract contains the following functions:

setPrice(uint256 _price): This function sets the price for creating a new NFT.

mintImage(string memory _imageType, string memory _imageHash): This function creates a new NFT representing a medical image. The user must pay the price set by the owner to mint the image.

getImage(uint256 _id): This function returns the image type and image hash associated with a particular NFT.

transferImage(address _to, uint256 _id): This function allows a user to transfer an NFT to another address.

Example
Here is an example of how to use the MedicalImageExchange smart contract:

javascript
Copy code
// Deploy the contract
const MedicalImageExchange = artifacts.require("MedicalImageExchange");
const contract = await MedicalImageExchange.deployed();

// Set the price for creating a new NFT
await contract.setPrice(1 ether);

// Create a new NFT representing an XR scan
await contract.mintImage("XR", "hash");

// Get the image type and image hash associated with the NFT
const [imageType, imageHash] = await contract.getImage(1);

// Transfer the NFT to another address
await contract.transferImage("0x1234567890123456789012345678901234567890", 1);
Contributing
Contributions are welcome! Please open an issue or pull request for any changes or additions.

License
This project is licensed under the MIT License - see the LICENSE file for details.
