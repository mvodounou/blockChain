// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function getBalance(address) {
  const balanceBigint = await hre.waffle.provider.getBalance(address);
  return hre.ethers.utils.formatEther(balanceBigint);
}

async function main() {

  const BuyMeAcoffee = await hre.ethers.getContractFactory("BuyMeAcoffee");
  const buyMeAcoffee = await BuyMeAcoffee.deploy();

  await buyMeAcoffee.deployed();

  console.log(
    `Contract deployed to ${buyMeAcoffee.address} & balance is ${await getBalance(buyMeAcoffee.address)}`
  );


}



// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
