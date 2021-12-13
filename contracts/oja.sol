//SPXD-Lincense-Identifier:MIT
pragma solidity ^0.8.4;
import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
//security against transactions for multiple requests
import '@openzeppelin/contracts/security/ReentrancyGuard.sol';
import '@openzeppelin/contracts/utils/Counters.sol';
import 'hardhat/console.sol';

contract Oja is ReentrancyGuard{
    //counters will keep track of items minting,transactions, sold tokens. total tokens(tokenid)
    using Counters for Counters.Counter; 
    Counters.Counter private  _tokenIds;
     Counters.Counter private  _tokensSold;

//determines the owner of the contract
     address payable owner;

     uint256 listingPrice = 0.045 ether;

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
// struct Bids{
//     uint256 startDate;
//     uint256 endDate;
//     uint256 minBidPrice;
//     uint256 currentBidPrice;
//     marketToken bidder;
//     uint256[] totalBiddings;
//     address[] currentBidders;
// }

//tokenId returns which marketToken - fetch which one it is
mapping (uint256 => marketToken) private tokenItems;

//listen to events from front-end applications
event marketTokenMinted(uint indexed itemId, address indexed nftContract, uint256 indexed tokenId, address seller, address buyer, uint256 price, bool sold);

//get the listing price
function getListingPrice()public view returns(uint256){
    return listingPrice;

}
//nonReentrant is a modifier to prevent reentry attack
function makeMarketItem(address nftContract, uint tokenId, uint256 price) public payable nonReentrant{
require(price > 0, "price must be at least one wei");
require(msg.value == listingPrice, "price must be equal to listing price");
_tokenIds.increment();
uint itemId = _tokenIds.current();

//putting it up for sale - bool - no owner
tokenItems[itemId] = marketToken(itemId, nftContract,  tokenId,  payable (msg.sender),payable (address(0)), price,  false);

//NFT transaction
IERC721(nftContract).transferFrom(msg.sender, address(this),tokenId);

emit marketTokenMinted(itemId ,nftContract, tokenId, msg.sender, address(0) , price , false);
}

function createMarketSale(address nftContract, uint itemId) public payable nonReentrant{
    uint price = tokenItems[itemId].price;
    uint tokenId = tokenItems[itemId].tokenId;
    require(msg.value == price, "please submit the asking price in other to continue");
    //transfer the amount to the seller
    tokenItems[itemId].seller.transfer(msg.value);
    //transfer the token from contract address to the buyer
    IERC721(nftContract).transferFrom(address(this),msg.sender,tokenId);
    tokenItems[itemId].sold = true;
    _tokensSold.increment();

    payable(owner).transfer(getListingPrice());

}
//FUCNTION TO FETMARKETITEMS  - MINTING, BUYING AND SELLING
function fetchMarketTokens()public view returns (marketToken[] memory){
uint itemCount = _tokenIds.current();
uint unsoldItemCount = _tokenIds.current() - _tokensSold.current();
uint currentIndex = 0;

//looping over the number of items created(if number has not been sold populate the array)
marketToken[] memory items = new marketToken[](unsoldItemCount);
for(uint i=0;i< itemCount;i++){
    if(
        tokenItems[i++].owner == address(0)
    ){
        uint currentId = i ++;
        marketToken storage currentItem = tokenItems[currentId];
        items[currentIndex] = currentItem;
        currentIndex +=1;
    }
}
return items;

}
function fetchMyNfts() public view returns(marketToken[] memory){
    uint totalItemCount = _tokenIds.current();
     uint itemCount = 0;
     uint currentIndex = 0;

     for(uint i =0; i < totalItemCount;i++){
         if(tokenItems[i + 1].owner == msg.sender){
             itemCount += 1;
         }
     }
     //second loop through the amount you have pruchased with itemcount. check to see if the owner address is equal to msg.sender
     marketToken[] memory items = new marketToken[](itemCount);
      for(uint i =0; i < totalItemCount;i++){
         if(tokenItems[i+1].owner == msg.sender){
uint currentId = tokenItems[i+1].itemId;
//current array
marketToken storage currentItem = tokenItems[currentId];
items[currentIndex] = currentItem;
currentIndex += 1;

     }        
    }
 return items;
}

        // function for returning an array of minted nfts
        function fetchItemsCreated() public view returns(MarketToken[] memory) {
            // instead of .owner it will be the .seller
            uint totalItemCount = _tokenIds.current();
            uint itemCount = 0;
            uint currentIndex = 0;

      for(uint i = 0; i < totalItemCount; i++) {
                if(idToMarketToken[i + 1].seller == msg.sender) {
                    itemCount += 1;
                }
            }

            // second loop to loop through the amount you have purchased with itemcount
            // check to see if the owner address is equal to msg.sender

            MarketToken[] memory items = new MarketToken[](itemCount);
            for(uint i = 0; i < totalItemCount; i++) {
                if(idToMarketToken[i +1].seller == msg.sender) {
                    uint currentId = idToMarketToken[i + 1].itemId;
                    MarketToken storage currentItem = idToMarketToken[currentId];
                    items[currentIndex] = currentItem;
                    currentIndex += 1;
                }
        }
        return items;
    }
}



