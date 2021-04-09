require('dotenv').config();
const HDWalletProvider = require("@truffle/hdwallet-provider");
const { API_URL, PRIVATE_KEY } = process.env;

const fs = require('fs');
// const mnemonic = fs.readFileSync(".secret").toString().trim();

module.exports = {
  compilers: {
    solc: {
      version: '^0.6.6',
    },
  },
  networks: {
    kovan: {
      provider: function() {
        return new HDWalletProvider([PRIVATE_KEY], API_URL)
      },
      network_id: 42,
    }
  }
}