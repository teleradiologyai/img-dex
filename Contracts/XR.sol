// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract XRScansNFT is ERC721, Ownable {
    
    uint256 public totalSupply;
    
    struct Image {
        uint256 id;
        string uri;
        bool exists;
        address owner;
    }
    
    mapping(uint256 => Image) public images;
    mapping(address => uint256[]) public ownedImages;
    
    event ImageCreated(uint256 id, string uri, address owner);
    event ImageTransferred(uint256 id, address from, address to);
    
    constructor(string memory name, string memory symbol) ERC721(name, symbol) {}
    
    function mint(string memory uri) public onlyOwner {
        totalSupply++;
        Image memory image = Image(totalSupply, uri, true, owner());
        images[totalSupply] = image;
        _safeMint(msg.sender, totalSupply);
        ownedImages[msg.sender].push(totalSupply);
        emit ImageCreated(totalSupply, uri, msg.sender);
    }
    
    function transferImage(uint256 id, address to) public {
        require(_isApprovedOrOwner(msg.sender, id), "XRScansNFT: transfer caller is not owner nor approved");
        require(images[id].exists, "XRScansNFT: image does not exist");
        _transfer(msg.sender, to, id);
        images[id].owner = to;
        emit ImageTransferred(id, msg.sender, to);
    }
    
    function getOwnedImages() public view returns (uint256[] memory) {
        return ownedImages[msg.sender];
    }
}
