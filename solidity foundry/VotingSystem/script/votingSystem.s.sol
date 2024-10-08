// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "foundry/src/Script.sol";
import "../VotingSystem.sol"; // Sözleşme dosyasının yolu

contract DeployVotingSystem is Script {
    function run() external {
        vm.startBroadcast(); // Dağıtım işlemini başlat

        // VotingSystem sözleşmesini dağıt
        VotingSystem voting = new VotingSystem();

        vm.stopBroadcast(); // Dağıtım işlemini sonlandır
    }
}