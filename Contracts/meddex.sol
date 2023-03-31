pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MedicalImageExchange is ERC721 {
    address public owner;
    uint256 public price;
    uint256 public totalImages;

    struct Image {
        uint256 id;
        address owner;
        string imageType;
        string imageHash;
    }

    mapping (uint256 => Image) public images;

    constructor() ERC721("MedicalImageExchange", "TRAI") {
        owner = msg.sender;
        price = 1 ether;
        totalImages = 0;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can execute this function");
        _;
    }

    function setPrice(uint256 _price) public onlyOwner {
        price = _price;
    }

    function mintImage(string memory _imageType, string memory _imageHash) public payable {
        require(msg.value == price, "Insufficient funds");

        totalImages += 1;

        images[totalImages] = Image({
            id: totalImages,
            owner: msg.sender,
            imageType: _imageType,
            imageHash: _imageHash
        });

        _mint(msg.sender, totalImages);
    }

    function getImage(uint256 _id) public view returns (string memory, string memory) {
        require(_id <= totalImages && _id > 0, "Invalid ID");

        return (images[_id].imageType, images[_id].imageHash);
    }

    function transferImage(address _to, uint256 _id) public {
        require(_id <= totalImages && _id > 0, "Invalid ID");

        safeTransferFrom(msg.sender, _to, _id);
    }
}
