var Revoke = artifacts.require("./Revoke.sol");
var Web3 = require('web3')

if (typeof web3 !== 'undefined') {
  web3 = new Web3(web3.currentProvider);
} else {
  // set the provider you want from Web3.providers
  web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
}


var stuffToSend =
{
  ipfsLink:web3.sha3("QmdrnPNKCUGFHs6r4KiG6PRw6dg3bEjoC6XjeS7fdD1yxz")

}



module.exports = function(deployer) {
  deployer.deploy(Revoke,stuffToSend.ipfsLink ,{gas: 670000});
};