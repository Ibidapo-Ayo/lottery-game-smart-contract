// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import {VRFConsumerBaseV2} from "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";
import {VRFCoordinatorV2Interface} from "@chainlink/contracts@1.2.0/src/v0.8/vrf/interfaces/VRFCoordinatorV2Interface.sol";


abstract contract RandomNumberConsumer is VRFConsumerBaseV2 {
    bytes32 public keyHash;
    uint256 public fee;
    uint256 public randomResult;

   VRFCoordinatorV2Interface COORDINATOR;
    uint64 s_subscriptionId;
    address s_owner;
    address vrfCoordinator = 0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625;
    bytes32 s_keyHash = 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c;
    uint32 callbackGasLimit = 40000;
    uint16 requestConfirmations = 3;
    uint32 numWords =  1;

    constructor(uint64 subscriptionId) VRFConsumerBaseV2(vrfCoordinator){
        COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
        s_owner = msg.sender;
        s_subscriptionId = subscriptionId;
    }

    modifier onlyOwner() {
        require(msg.sender == s_owner, "Only contract owner can modify make this changes");
        _;
    }
}