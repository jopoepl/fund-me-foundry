// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";

import {MockV3Aggregator} from "../test/mock/MockV3Aggregator.sol";

abstract contract CodeConstants {
    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    /*//////////////////////////////////////////////////////////////
                               CHAIN IDS
    //////////////////////////////////////////////////////////////*/
    uint256 public constant ETH_SEPOLIA_CHAIN_ID = 11155111;
    uint256 public constant ZKSYNC_SEPOLIA_CHAIN_ID = 300;
    uint256 public constant LOCAL_CHAIN_ID = 31337;
}

contract HelperConfig is Script {
    //Lets list what helper config is doing
    // It is a script that extends the script from forge-std
    //It will select the correct network based on the chain id
    //It will return the price feed address for the selected network

    //STRUCTURE OF THE SCRIPT
    //Create a struct called NetworkConfig
    //Initialize a variable called activeNetworkConfig that ll hold the active network configation
    //Set this activeNetwork config depending on the active network from chain.id
    //Create a function that ll set the address of the price feed based on chain id recd
    //For now lets focus on two chains sepolia testnet and the local testnet anvil

    // This struct will hold the configuration for each network
    struct NetworkConfig {
        address priceFeed;
    }

    NetworkConfig public activeNetworkConfig;

    /*//////////////////////////////////////////////////////////////
                              CONSTANT CHAIN IDs
    //////////////////////////////////////////////////////////////*/
    uint256 public constant ETH_SEPOLIA_CHAIN_ID = 11155111;
    // uint256 public constant ZKSYNC_SEPOLIA_CHAIN_ID = 300;
    uint256 public constant LOCAL_CHAIN_ID = 31337;
    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    constructor() {
        if (block.chainid == ETH_SEPOLIA_CHAIN_ID) {
            activeNetworkConfig = getSepoliaEthConfig();
        } else {
            activeNetworkConfig = getAnvilConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig = NetworkConfig({priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306}); // ETH / USD
        return sepoliaConfig;
    }

    //why am i getting parse error return is not formatted correctly?
    //how to fix it?

    function getAnvilConfig() public returns (NetworkConfig memory) {
       

        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({priceFeed: address(mockPriceFeed)}); // ETH / USD
        return anvilConfig;

    }

    //where will i get price feed address for anvil?
    //we will use chainlink price feed for anvil
    //how will we use chainlink price feed for anvil? It doesnt have a real price feed address
    //will i have to create a mock?
    //how to create a mock?
}
