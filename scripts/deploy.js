const hre = require("hardhat")
const fs = require('fs')


async function main() {
 
  const NFTMarket = await hre.ethers.getContractFactory("Oja");
  const nftMarket = await NFTMarket.deploy();
  await nftMarket.deployed();
  console.log("NftMarket deployed to:", nftMarket.address);

  const NFT = await hre.ethers.getContractFactory("NFT");
  const nft = await NFT.deploy(nftMarket.address);
  await nft.deployed();
  console.log("NFT contract deployed to:", nftMarket.address);

  let config = `
  export const nftMarketAddress = ${nftMarket.address}
  export const nftAddress = ${nft.address}`

  let data = JSON.stringify(config) //parse the above info into a string
  fs.writeFileSync('config.js', JSON.parse(data))

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
