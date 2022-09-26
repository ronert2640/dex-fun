pragma solidity >=0.5.0;

import "forge-std/Test.Sol";
import "../src/UniswapTest.sol";
import "../interfaces/IERC20.sol";
//import "@openzepp"


contract UniswapTestTester is Test {

    using stdStorage for StdStorage;
    UniswapTest public testContract;

    address public constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address public constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

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

    function testSwap() public {
        // List of token address to swap
        address[] memory s_tokens = new address[](2);
        s_tokens[0] = address(DAI);
        s_tokens[1] = address(USDC); // Add some logs here
        uint[] memory test = testContract.swap(1, 1, s_tokens, address(this), 1 minutes); // Using address(this) to test... add assetEq(balance(this) > 0)
    }
    /*
    function testAmountsOut() public {
        address[2] memory s_path = [DAI, USDC];
    }
    */
}
