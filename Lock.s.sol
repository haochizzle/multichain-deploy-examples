// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;


import {Script, console} from "forge-std/Script.sol";
import {CrosschainDeployScript} from "foundry-multichain-deploy/CrosschainDeployScript.sol";

contract LockScript is CrosschainDeployScript {

    function run() public {
    string memory artifact = "Lock.sol:Lock";
    this.setContract(artifact);

    // Assuming an unlock time in the future. Adjust the time as necessary.
       uint256 unlockTimeInTheFuture = block.timestamp + 1 days;
       address ownerAddress = vm.envAddress("DEPLOYER_ADDRESS");

    // Encode constructor arguments: owner address and unlock time.
       bytes memory constructorArgs = abi.encode(ownerAddress, unlockTimeInTheFuture);

    // Optionally, encode `initData` if you wish to call `setName` post-deployment.
    // Example: setting name to the name of the chain we are deploying to
        bytes memory initDataSepolia = abi.encodeWithSignature("setName(string)", "Sepolia");
        bytes memory initDataHolesky = abi.encodeWithSignature("setName(string)", "Holesky");
        bytes memory initDataMumbai = abi.encodeWithSignature("setName(string)", "Mumbai");

        this.addDeploymentTarget("sepolia", constructorArgs, initDataSepolia);
        this.addDeploymentTarget("holesky", constructorArgs, initDataHolesky);
        this.addDeploymentTarget("mumbai", constructorArgs, initDataMumbai);

    // Adjust the gas limit as necessary
        uint256 destinationGasLimit = 600000; // Increased due to potentially higher cost
        uint256[] memory fees = this.getFees(destinationGasLimit, false);
        uint256 totalFee = this.getTotalFee(destinationGasLimit, false);

    // Ensure PRIVATE_KEY is set in your environment variables
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address[] memory contractAddresses =
        this.deploy{value: totalFee}(deployerPrivateKey, fees, destinationGasLimit, false);

        console.log("Sepolia contract address %s", contractAddresses[0]);
        console.log("Holesky contract address %s", contractAddresses[1]);
        console.log("Mumbai contract address %s", contractAddresses[2]);
        console.log("Unlock Time (in seconds since Unix epoch): %s", unlockTimeInTheFuture);

    }
}
