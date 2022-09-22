pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/ParaSwapTest.sol";

contract ParaSwapTestTester is Test {
    ParaSwapTest public test;

    function setUp() public {
        test = new ParaSwapTest();
    }
    /*
    function testIncrement() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }
    */
}