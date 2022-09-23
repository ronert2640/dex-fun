pragma solidity ^0.8.17;

import "forge-std/Test.Sol";
import "../src/UniswapTest.sol";
import "../interfaces/IERC20.sol";
//import "@openzepp"


contract UniswapTestTester is Test {

    using stdStorage for StdStorage;
    UniswapTest public testContract;

    function setUp() public {
        testContract = new UniswapTest();
        stdstore
            .target(address(0x6B175474E89094C44Da98b954EedeAC495271d0F)) // DAI Address ( Main Network )
            .sig(IERC20(address(0x6B175474E89094C44Da98b954EedeAC495271d0F)).balanceOf.selector)
            .with_key(address(testContract))
            .checked_write(1000 * 1e18);
    }

    function testBalanceOf() public {
        uint256 balance = testContract.getBalance();
        assertEq(balance, 1000000000000000000000); // Expect to have 1000 Dai
    }

    function testRouter() public {
        address routerAddress = testContract.getRouter();
        assertEq(routerAddress, address(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D));
    }
}