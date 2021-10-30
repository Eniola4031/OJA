const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("oja", function () {
  it("should mint and trade NFTs", async function () {
const Market = await ethers.getContractFactory('oja')
const market = await Market.deploy()
await market.deployed()
const marketAddress = market.address

const NFT = await ethers.getContractFactory('NFT')
const nft = await NFT.deploy(marketAddress)
await nft.deployed()
const nftContractAddress = nft.address

let listingPrice = await market.getListingPrice()
listingPrice = listingPrice.toString()

const auctionPrice = ethers.utils.parseUnits('100','ether')

//test for minting
await nft.mintToken('https-t1')
await nft.mintToken('https-t2')
await nft.mintToken('https-t3')
await nft.mintToken('https-t4')

await market.makeMarketItem(nftContractAddress, 1, auctionPrice, {value: lisitngPrice})
await market.makeMarketItem(nftContractAddress, 2, auctionPrice, {value: lisitngPrice})

const [_, buyerAddress]= await ethers.getSigners()

//create a market sale with address, id and price
await market.connect(buyerAddress).createMarketSale(nftContractAddress, 1, {value: auctionPrice})

const items = await market.fetchMarketTokens()

//test out all items
console.log('items',items)



  });
  });
