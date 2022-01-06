const { expect } = require('chai');
const { ethers, upgrades } = require('hardhat');

let DBVNFT;
let proxy;
let owner;

describe('DBVNFT (Proxy)', function () {
  // Set up initial conditions for our test
  beforeEach(async function () {
    owner = await ethers.getSigner();
    DBVNFT = await ethers.getContractFactory('DBVNFT');
    proxy = await upgrades.deployProxy(
      DBVNFT,
      ['Dragon Ball Villans', 'DBV', 'https://dhsgucezdnqh.usemoralis.com/'],
      {
        initializer: 'initialize',
      }
    );
  });

  // Run our tests
  it('Return owners balance', async function () {
    let balance = await proxy.balanceOf(owner.address);
    expect(balance).to.equal(2);
  });
});
