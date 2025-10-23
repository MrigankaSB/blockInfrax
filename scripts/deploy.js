const hre = require("hardhat");

async function main() {
  const BlockInfraX = await hre.ethers.getContractFactory("BlockInfraX");
  const blockInfraX = await BlockInfraX.deploy();
  await blockInfraX.deployed();

  console.log(`✅ BlockInfraX deployed successfully to: ${blockInfraX.address}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("❌ Deployment failed:", error);
    process.exit(1);
  });
