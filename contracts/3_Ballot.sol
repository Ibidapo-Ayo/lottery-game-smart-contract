// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Lottery {
    address public manager;
    address[]  public players;

    constructor() {
        manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value >= .01 ether, "Insuffient funds");
        require(msg.sender != manager, "Contract is not allowed to join");
        players.push(msg.sender);
    }

    function pickRandomWinner() public returns (address) {
        uint256 index = random() % players.length;
        address payable winner = payable(players[index]);
        winner.transfer(address(this).balance);
        return winner;
    }

    function random() public view returns (uint256) {
        return uint256(keccak256(abi.encode(block.prevrandao)));
    }
}
