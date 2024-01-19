const hre = require("hardhat");

async function main() {
  const SimpleStaking = await hre.ethers.getContractFactory("SimpleStaking");
  const staking = await SimpleStaking.deploy();

  await staking.waitForDeployment();

  console.log("SimpleStaking deployed to:", staking.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
