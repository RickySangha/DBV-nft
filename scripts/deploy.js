const { ethers, upgrades } = require('hardhat');

async function main() {
  const owner = await ethers.getSigner();
  console.log('Deploying contracts with the account:', owner.address);

  const DBVNFT = await ethers.getContractFactory('DBVNFT');
  const proxy = await upgrades.deployProxy(
    DBVNFT,
    ['Dragon Ball Villans', 'DBV', 'https://dhsgucezdnqh.usemoralis.com/'],
    {
      initializer: 'initialize',
    }
  );
  console.log('Deployed to:', proxy.address);
}

main()
  .then(() => {
    process.exit(0);
  })
  .catch((error) => {
    console.log(error);
    process.exit(1);
  });
