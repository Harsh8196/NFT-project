const SmartContract = artifacts.require("SmartContract");

module.exports = function (deployer,network,accounts) {
  deployer.deploy(SmartContract,{from:accounts[0]});
};
