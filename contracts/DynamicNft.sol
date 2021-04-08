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
    uint256 public randomNumber;
    address public VRFCoordinator;
    address public LINKToken;
    string requestToSender;
    string requestToTokenId;

    constructor(address _VRFCoordinator, address _LINKToken, uint256 _keyhash) 
    public
    VRFCoordinator(_VRFCoordinator, _LINKToken)
    ERC721("DynamicNFT", "SPS"){

        VRFCoordinator = _VRFCoordinator;
        LINKToken = _LINKToken;
        keyhash = _keyhash;
        fee = 0.1 * 10**18;
    }
}