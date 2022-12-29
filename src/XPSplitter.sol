pragma solidity ^0.8.17;

contract XPSplitter {
    fallback() external payable {
        address payable XPAddress = payable(0x6C4dc45b51bB46A60B99fB5395692ce11bBE49C5);
        address payable clientAddress = payable(0x3443d0a6956e7E0A13Cd1c54F6bEf24B0d54f420);
        uint256 amountToSplit = msg.value;
        uint256 amountForClient = (400 * amountToSplit) / 10000;
        uint256 amountForXP = amountToSplit - amountForClient;
        XPAddress.call{value: amountForXP, gas: 0}("");
        clientAddress.call{value: amountForClient, gas: 0}("");
    }
}