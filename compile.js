const path = require("path");
const fs = require("fs");
const solc = require("solc");

const lotteryPath = path.join(__dirname, "contracts", "Lottery.sol");
const source = fs.readFileSync(lotteryPath, "utf-8");

let input = {
  language: "Solidity",
  sources: {
    [lotteryPath]: {
      content: source,
    },
  },

  settings: {
    outputSelection: {
      "*": {
        "*": ["*"],
      },
    },
  },
};

const output = JSON.parse(solc.compile(JSON.stringify(input)));

module.exports = {
  abi: output.contracts[[lotteryPath]]["Lottery"].abi,
  bytecode: output.contracts[[lotteryPath]]["Lottery"].evm.bytecode.object,
};
