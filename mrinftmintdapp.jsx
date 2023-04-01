import React, { useState } from "react";
import axios from "axios";

function App() {
  const [minting, setMinting] = useState(false);
  const [minted, setMinted] = useState(false);

  const handleMintNFT = async () => {
    setMinting(true);
    try {
      // Make a POST request to the OpenSea API to mint the MRI NFT
      await axios.post(
        "https://api.opensea.io/api/v1/assets",
        {
          token_id: "12345", // Replace with the actual token ID for the MRI NFT
          asset_contract_address: "0x1234567890", // Replace with the actual contract address for the MRI NFT
          account_address: "0xabcdef123456", // Replace with the user's Ethereum wallet address
        },
        {
          headers: {
            "X-API-KEY": "1234567890", // Replace with your actual OpenSea API key
            "Content-Type": "application/json",
          },
        }
      );
      setMinted(true);
    } catch (error) {
      console.error(error);
    }
    setMinting(false);
  };

  return (
    <div>
      <h1>Mint MRI NFT</h1>
      <p>Click the button below to mint your MRI NFT.</p>
      <button onClick={handleMintNFT} disabled={minting || minted}>
        {minting ? "Minting..." : minted ? "Minted!" : "Mint NFT"}
      </button>
    </div>
  );
}

export default App;
