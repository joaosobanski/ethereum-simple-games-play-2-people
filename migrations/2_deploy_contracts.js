const Name = artifacts.require("Name");
const JogoDaVelha = artifacts.require("JogoDaVelha");


module.exports = function (deployer) {
  deployer.deploy(Name);
  deployer.deploy(JogoDaVelha);
};
