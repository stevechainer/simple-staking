const { expect } = require("chai");

describe("SimpleStaking", function () {
  it("Should allow users to stake and withdraw", async function () {
    const SimpleStaking = await ethers.getContractFactory("SimpleStaking");
    const staking = await SimpleStaking.deploy();
    // await staking.deployed(); // This line is not needed in Hardhat

    const [owner] = await ethers.getSigners();

    const stakeAmount = ethers.utils.parseEther("1.0");
    await staking.stake({ value: stakeAmount });

    expect(await staking.getBalance()).to.equal(stakeAmount);

    await staking.withdraw();
    expect(await staking.getBalance()).to.equal(0);
  });
});
