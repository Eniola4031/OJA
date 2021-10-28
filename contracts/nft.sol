//SPXD-Lincense-Identifier:MIT
pragma solidity ^o.8.4;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol';
import '@openzeppelin/contracts/utils/Counters.sol';

contract NFT is ERC721URIStorage{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    //counters allow us keep tract of tokenIds
    //address of market place for NFTs to interact

    address contractAddress;

    //
}