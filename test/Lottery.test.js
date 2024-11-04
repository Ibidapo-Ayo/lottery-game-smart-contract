const assert = require("assert");
const ganache = require("ganache");
const { Web3 } = require("web3");
const { abi, bytecode } = require("../compile");

const web3 = new Web3(ganache.provider());

let accounts;
let lottery;

beforeEach(async () => {
  accounts = await web3.eth.getAccounts();

  lottery = await new web3.eth.Contract(abi)
    .deploy({
      data: bytecode,
    })
    .send({
      from: accounts[0],
      gas: "3000000",
    });
});



describe("Lottery", () => {
  it("deploys a contract", () => {
    assert.ok(lottery.options.address);
  });

  it("enter the lottery", async () => {
    await lottery.methods.enter().send({
      from: accounts[1],
      value: web3.utils.toWei("0.01", "ether"),
    });

    await lottery.methods.returnEntries().call({
      from: accounts[0],
    });
  });

  it("allow multiple accounts to enter", async () => {
    await lottery.methods.enter().send({
      from: accounts[1],
      value: web3.utils.toWei("0.01", "ether"),
    });
    await lottery.methods.enter().send({
      from: accounts[2],
      value: web3.utils.toWei("0.01", "ether"),
    });
    await lottery.methods.enter().send({
      from: accounts[2],
      value: web3.utils.toWei("0.01", "ether"),
    });
  });
});
