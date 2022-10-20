const hre = require("hardhat");

async function main(){

    const BuyMeAcoffee = await hre.ethers.getContractFactory("BuyMeAcoffee");
    const buyMeAcoffee = await BuyMeAcoffee.deploy();
    await buyMeAcoffee.deployed();

    console.log(
        `Contract deployed to ${buyMeAcoffee.address}` /// 0x12aA257f4EB532cA8C31De4f5B74f56F8DE69634
    );
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });