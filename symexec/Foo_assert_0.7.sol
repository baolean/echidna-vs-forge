pragma solidity ^0.7.6;

contract Foo {
    uint256 internal constant MAGIC = 0x69;

    uint256 internal flagA = 0;
    uint256 internal flagB = 0;

    function foo(uint256 x) public {
        assembly {
            if iszero(xor(x, MAGIC)) {
                sstore(flagA.slot, 0x01)
            }
        }
    }

    function bar(uint256 y) public {
        assembly {
            if iszero(xor(y, MAGIC)) {
                sstore(flagB.slot, 0x01)
            }
        }
    }

    function revertIfCracked(uint x, uint y) public view {
        bool res = true;
        assembly {
            if and(sload(flagA.slot), sload(flagB.slot)) {
                res := false
            }
        }
        assert(res);
    }
}
