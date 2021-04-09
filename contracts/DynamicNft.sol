// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract DynamicNft is ERC721, VRFConsumerBase, Ownable {

    using SafeMath for uint256;
    using Strings for string;

    bytes32 internal keyhash;
    uint256 internal fee;
    uint256 public randomResult;
    address public VRFCoordinator;
    address public LINKToken;
    uint256 tokenId;

    struct Spaceship {
        uint8 width;
        uint8 height;
        string createdAt;
        string format;
        string url;
    }

    Spaceship public spaceship;

    constructor(address _VRFCoordinator, address _LINKToken, bytes32 _keyhash) 
    public
    VRFConsumerBase(_VRFCoordinator, _LINKToken)
    ERC721("DynamicNFT", "SPS"){

        VRFCoordinator = _VRFCoordinator;
        LINKToken = _LINKToken;
        keyhash = _keyhash;
        fee = 0.1 * 10**18;
    }

    function getSpaceshipOverview() public view returns ( 
        uint8, 
        uint8, 
        string memory, 
        string memory, 
        string memory){

        return (
            spaceship.width,
            spaceship.height,
            spaceship.createdAt,
            spaceship.format,
            spaceship.url
        );
    }

    function requestRandomId(uint256 userProvidedSeed) public returns(bytes32 requestId){
        require(LINK.balanceOf(address(this)), "Transaction failed - out of LINK!");
        bytes32 requestId = requestRandomness(keyhash, fee, userProvidedSeed);
        return requestId;
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomNumber)
        internal
        override    {

            tokenId = randomNumber;
    }

    function getWidth() public view returns (uint8){
        return spaceship.width;
    }

    function getHeight() public view returns (uint8){
        return spaceship.height;
    }

    function getCreationTime() public view returns (string memory){
        return spaceship.createdAt;
    }

    function getFormat() public view returns (string memory){
        return spaceship.format;
    }

    function getSourcUrl() public view returns (string memory){
        return spaceship.url;
    }
}