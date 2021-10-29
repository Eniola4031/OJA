//SPXD-Lincense-Identifier:MIT
pragma solidity ^0.8.4;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
//security against transactions for multiple requests
import '@openzeppelin/contracts/security/ReentrancyGuard.sol';
import '@openzeppelin/contracts/utils/Counters.sol';
import 'hardhat/console.sol';

contract oja is ReentrancyGuard{
    //counters will keep track of items minting,transactions, sold tokens. total tokens(tokenid)
    using Counters for Counters.Counters; 
    Counters.Counter private  _tokenIds;
     Counters.Counter private  _tokensSold;

//determines the owner of the contract
     address payable owner;

     uint256 listingPrice = 0.045ether;

     constructor(){
         //set the owner
         owner = payable(msg.sender);
     }

//structs can act like objects
struct marketToken{
    uint itemId;
    address nftContract;
    uint256 tokenId;
    address payable seller;
    address payable owner;
    uint256 price;
    bool sold;
}
struct Bids{
    uint256 startDate;
    uint256 endDate;
    uint256 minBidPrice;
    uint256 currentBidPrice;
    marketToken bidder;
    uint256[] totalBiddings;
    address[] currentBidders;
}

//tokenId returns which marketToken - fetch which one it is
mapping (uint256 => marketToken) private tokenItems;

//listen to events from front-end applications
event marketTokenMinted(uint indexed tokenId, address indexed nftContract, uint256 indexed tokenId, address seller, address buyer, uint256 price, bool sold);

//get the listing price
function getListingPrice()public view returns(uint256){
    return listingPrice;

}
//nonReentrant is a modifier to prevent reentry attack
function mintMarketItem(address nftContract, uint tokenId, uint price) public payable nonReentrant{
require(price > 0, "price must be at least one wei");
require(msg.value == listingPrice, "price must be equal to listing price");
_tokenIds++;
uint itemId = _tokenIds.current();

//putting it up for sale - bool - no owner
tokenItems[itemId] = marketToken(itemId, nftContract,  tokenId,  payable (msg.sender),payable (address(0)), price,  false);

//NFT transaction
IERC721(nftContract).transferFrom(msg.sender, address(this),tokenId)

emit marketTokenMinted(itemId ,nftContract, tokenId, msg.sender, address(0) , price , false);

}

function sellTokens(){

}
}