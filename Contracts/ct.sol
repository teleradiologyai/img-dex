// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract CTScans is ERC721 {
    struct Scan {
        string scanID;
        string scanType;
        string scanData;
        uint256 timestamp;
        address owner;
    }

    mapping (uint256 => Scan) private _scans;
    uint256 private _scanCount;

    constructor() ERC721("TeleradiologyAI CT Scans", "TRAI-CT") {}

    function createScan(string memory scanID, string memory scanType, string memory scanData) public returns (uint256) {
        _scanCount++;
        uint256 tokenId = _scanCount;
        Scan storage newScan = _scans[tokenId];
        newScan.scanID = scanID;
        newScan.scanType = scanType;
        newScan.scanData = scanData;
        newScan.timestamp = block.timestamp;
        newScan.owner = msg.sender;
        _safeMint(msg.sender, tokenId);
        return tokenId;
    }

    function getScan(uint256 tokenId) public view returns (string memory, string memory, string memory, uint256, address) {
        require(_exists(tokenId), "Scan does not exist");
        Scan storage scan = _scans[tokenId];
        return (scan.scanID, scan.scanType, scan.scanData, scan.timestamp, scan.owner);
    }
}
