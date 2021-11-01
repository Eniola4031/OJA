//SPXD-Lincense-Identifier:MIT
pragma solidity ^0.8.4;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol';
import '@openzeppelin/contracts/utils/Counters.sol';

contract NFT is ERC721URIStorage{
    using Counters for Counters.Counter;
        //counters allow us keep tract of tokenIds
    Counters.Counter private _tokenIds;
    
    //address of market place for NFTs to interact
    address contractAddress;

    //gives the marketplace the ability to transact with tokens or change ownership
    //setApprovalForAll allows us change ownership with the contract address
    constructor(address ojaAddress) ERC721('NFT OJA', 'OJ'){
    contractAddress = ojaAddress;
    }


function mintToken(string memory tokenURI) public returns(uint){
    _tokenIds.increment();
    uint256 newItemId = _tokenIds.current();
    _mint(msg.sender,newItemId);
    //set the token URI; id and uri
    _setTokenURI(newItemId, tokenURI);
    //give the marketplace the approval to transact between users
    setApprovalForAll(contractAddress, true);
    //mint the token and set it for sale - return the id to do so
    return newItemId;
}
}