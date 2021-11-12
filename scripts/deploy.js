const hre = require("hardhat");
const fs = require('fs')


async function main() {
 
  const OjaMarket = await hre.ethers.getContractFactory("Oja");
  const ojaMarket = await Oja.deploy();
  await ojaMarket.deployed();
  console.log("NftMarket deployed to:", ojaMarket.address);

  const NFT = await hre.ethers.getContractFactory("NFT");
  const nft = await NFT.deploy(nftmarketaddress);
  await nft.deployed();
  console.log("NFT coontract deployed to:", ojaMarket.address);

  let config = '

  export const nftMarketAddress = ${nftMarket.address}
  export const nftAddress = ${nftAddress.address}'

  let data = JSON.stringify(config)
  fs.writeFileSync
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
