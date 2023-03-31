// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTMRI is ERC721URIStorage, Ownable {

    struct MRI {
        address owner;
        string scanUrl;
    }

    mapping(uint256 => MRI) private _mris;
    uint256 private _tokenIdCounter;

    constructor() ERC721("NFTMRI", "MRI") {}

    function mintMRI(address to, string memory scanUrl) public onlyOwner returns (uint256) {
        uint256 tokenId = _tokenIdCounter;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, scanUrl);
        _mris[tokenId] = MRI(to, scanUrl);
        _tokenIdCounter = _tokenIdCounter + 1;
        return tokenId;
    }

    function getMRI(uint256 tokenId) public view returns (address, string memory) {
        require(_exists(tokenId), "NFTMRI: Token does not exist");
        MRI memory mri = _mris[tokenId];
        return (mri.owner, mri.scanUrl);
    }
}
