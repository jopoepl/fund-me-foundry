//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {FundMe} from "../src/FundMe.sol";
import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";



    contract FundFundMe is Script {
        uint256 constant AMOUNT_FUNDED = 1e18; 

        function fundContract(address mostRecentDeployment) public {
            vm.startBroadcast();
            FundMe(payable(mostRecentDeployment)).fund{value: AMOUNT_FUNDED}();
            vm.stopBroadcast();
        }

        //Fund the contract
        function run() external {

            address mostRecentDeployment = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
            fundContract(mostRecentDeployment);
        }
    }

    contract WithdrawFundMe is Script {
      
        uint256 constant AMOUNT_FUNDED = 1e18; 

        function withdrawFundMeContract(address mostRecentDeployment) public {
            vm.startBroadcast();
            FundMe(payable(mostRecentDeployment)).withdraw();
            vm.stopBroadcast();
        }

        //Fund the contract
        function run() external {

            address mostRecentDeployment = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
            withdrawFundMeContract(mostRecentDeployment);
        }
    }   
    

    
