require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  etherscan: {
    apiKey: "1UF6NKNVYE7DP6W5QMFJ3ZN7YCM4K4B2XG",
  },
  networks: {
    sepolia: {
      // Ankr's Public RPC URL
      url: process.env.INFURA_SEPOLIA_ENDPOINT,
      // PRIVATE_KEY loaded from .env file
      accounts: [`0x${process.env.PRIVATE_KEY}`],
    },
    goerli: {
      // Ankr's Public RPC URL
      url: process.env.INFURA_GOERLI_ENDPOINT,
      // PRIVATE_KEY loaded from .env file
      accounts: [`0x${process.env.PRIVATE_KEY}`],
    },
  },
};
