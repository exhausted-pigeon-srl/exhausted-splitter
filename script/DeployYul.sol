// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

contract DeployYul is Script {

    function setUp() public {
    }

    function run() public {
        string memory bashCommand = 'cast abi-encode "f(bytes)" $(solc --yul yul/XPSplitter.yul --bin | tail -1)';

        string[] memory inputs = new string[](3);
        inputs[0] = "bash";
        inputs[1] = "-c";
        inputs[2] = bashCommand;

        bytes memory bytecode = abi.decode(vm.ffi(inputs), (bytes));
        address deployedAddress;

        vm.broadcast();
        assembly {
            deployedAddress := create(0, add(bytecode, 0x20), mload(bytecode))
        }

        require(
            deployedAddress != address(0),
            "YulDeployer could not deploy contract"
        );

        console.log(deployedAddress);
    }
}
