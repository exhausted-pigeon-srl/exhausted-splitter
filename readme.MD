# Minimal contract which splits every eth in into 2 addresses, at a given rate.
2 versions are available: coded in pure Yul or in pure assembly (ETK).

To run this repo, you'll need:
- Foundry: https://book.getfoundry.sh/getting-started/installation
- solc (*not* solcjs): https://docs.soliditylang.org/en/v0.8.17/installing-solidity.html
- ETK: https://github.com/quilt/etk

You can run the test using `forge test` or use the deploy scripts (`forge script DeployYul` or `forge script DeployAsm`) - do not forget to change the beneficiaries addresses!

# Gas consumption:
Assembly version is 26 units cheaper. Here is a full breakdown, by opcode (see the source code for comments, etc), the cost of call might be wrong tho (but should be identical between 2 versions anyway):

Total Yul: 68681 (81 calls excl.)
Total Asm: 68655 (55 calls excl.)

Cost breakdown Yul:
PUSH20 0x6c4dc45b51bb46a60b99fb5395692ce11bbe49c5 - 3
PUSH20 0x3443d0a6956e7e0a13cd1c54f6bef24b0d54f420 - 3
PUSH2 0x2710 - 3
PUSH2 0x0190 - 3
CALLVALUE - 2
MUL - 5
DIV - 5
PUSH1 0x00 - 3
DUP1 - 3
PUSH1 0x00 - 3
DUP1 - 3
DUP5 - 3
DUP7 - 3
PUSH1 0x00 - 3
CALL - 34300 (cold empty address, with a value passed)
POP - 2
PUSH1 0x00 - 3
DUP1 - 3
PUSH1 0x00 - 3
DUP1 - 3
DUP5 - 3
CALLVALUE - 2
SUB - 3
DUP8 - 3
PUSH1 0x00
CALL - 34300
POP - 2
POP - 2
POP - 2
POP - 2

Cost breakdown assembly:
returndatasize - 2
returndatasize - 2
returndatasize - 2
returndatasize - 2
push2 0x2710 - 3
push2 0x0190 - 3
callvalue - 2
mul - 5
div - 5
push20 0x3443d0a6956e7e0a13cd1c54f6bef24b0d54f420 - 3
returndatasize - 2
returndatasize - 2
returndatasize - 2
returndatasize - 2
returndatasize - 2
dup7 - 3
callvalue - 2
sub - 3
push20 0x6c4dc45b51bb46a60b99fb5395692ce11bbe49c5 - 3
returndatasize - 2
call - 34300
pop - 3
call - 34300
