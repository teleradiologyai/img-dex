pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TeleradID is ERC721, Ownable {
    
    uint256 public totalSupply;
    uint256 public maxSupply;
    uint256 public mintCost;
    
    mapping (uint256 => address) public tokenOwners;
    
    event TokenMinted(address indexed owner, uint256 indexed tokenId);
    
    constructor(string memory name, string memory symbol, uint256 _maxSupply, uint256 _mintCost) ERC721(name, symbol) {
        maxSupply = _maxSupply;
        mintCost = _mintCost;
    }
    
    function mintToken() public payable {
        require(totalSupply < maxSupply, "Maximum supply reached.");
        require(msg.value == mintCost, "Incorrect payment amount.");
        
        totalSupply++;
        uint256 tokenId = totalSupply;
        _safeMint(msg.sender, tokenId);
        tokenOwners[tokenId] = msg.sender;
        
        emit TokenMinted(msg.sender, tokenId);
    }
    
    function setMintCost(uint256 _mintCost) public onlyOwner {
        mintCost = _mintCost;
    }
    
    function withdraw() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
    
    function isTokenOwner(uint256 tokenId) public view returns (bool) {
        return (msg.sender == tokenOwners[tokenId]);
    }
}
