require("@nomicfoundation/hardhat-toolbox");
require("@chainsafe/hardhat-ts-artifact-plugin");
require("@nomicfoundation/hardhat-web3-v4");
require("@chainsafe/hardhat-plugin-multichain-deploy");
const { Environment } = require("@buildwithsygma/sygma-sdk-core");
require('dotenv').config();

const config = {
  solidity: "0.8.19",
  networks: {
    sepolia: {
      chainId: 11155111,
      url: "https://ethereum-sepolia.publicnode.com",
      // Use process.env to access environment variables
      accounts: process.env.PK ? [process.env.PK] : [],
       },
    mumbai: {
      chainId: 80001,
      url: "https://polygon-mumbai-pokt.nodies.app",
      // Use process.env to access environment variables
      accounts: process.env.PK ? [process.env.PK] : [],
       },
    holesky: {
      chainId: 17000,
      url: "https://ethereum-holesky-rpc.publicnode.com",
      accounts: process.env.PK ? [process.env.PK] : [],
      },
    },
  multichain: {
    environment: Environment.TESTNET,
  }
};

// Export the configuration object
module.exports = config;
