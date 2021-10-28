require("@nomiclabs/hardhat-waffle");
const projectId= 'b583db0f378647cab974157e3e555a93'
const fs = require('fs')
const keydata = fs.readFileSync('./pk.secret',{
encoding:'utf8', flag:'r'
})

module.exports = {
  defaultNetwork: 'hardhat',
  networks:{
    hardhat:{
      chainId:1337 //config standard
    },
    mumbai:{
      url:'https://polygon-mumbai.infura.io/v3/${projectId}',
      accounts:[keydata]
    },
    mainnet:{
      url:'https://mainnet.infura.io/v3/${projectId}',
      accounts:[keydata]
    }
  },
  solidity:{
    version:"0.8.4",
    settings:{
      optimizer:{
        enabled:true,
        runs:200
      }
    }
  } 
};
