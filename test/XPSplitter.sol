// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "./utils/YulDeployer.sol";

interface XPSPlitter {}

contract ExampleTest is Test {
    YulDeployer yulDeployer = new YulDeployer();

    XPSPlitter XPSPlitterContract;

    address XPAddress = address(0x6C4dc45b51bB46A60B99fB5395692ce11bBE49C5);
    address clientAddress = address(0x3443d0a6956e7E0A13Cd1c54F6bEf24B0d54f420);

    function setUp() public {
        XPSPlitterContract = XPSPlitter(yulDeployer.deployContract("XPSplitter"));
    }

    function testSplitter(uint256 _amountToSplit) public {
        vm.assume(_amountToSplit < msg.sender.balance);

        // Addresses hardcoded in the splitter
        uint256 _balanceXPBefore = XPAddress.balance;
        uint256 _balanceClientBefore = clientAddress.balance;
        
        // The actual call (call data are discarded)
        (bool success, bytes memory data) = address(XPSPlitterContract).call{value: _amountToSplit}('whateverCallData');

        // Check: call is successful and no data is returned?
        assertTrue(success);
        assertEq(data.length, 0);

        // Split hardcoded as 4% - 96% (floor for client, ceiling for XP, if rounding error)
        // Check: amounts sent are correct?
        assertEq(clientAddress.balance, _balanceClientBefore + (400 * _amountToSplit) / 10000);
        assertEq(XPAddress.balance, _balanceXPBefore + (_amountToSplit - (400 * _amountToSplit) / 10000));
    }
}

