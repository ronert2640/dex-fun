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
        // Spawn DAI
        stdstore
            .target(address(DAI)) // DAI Address ( Main Network )
            .sig(IERC20(address(DAI)).balanceOf.selector)
            .with_key(address(testContract))
            .checked_write(1000 * 1e18);
        // Spawn USDC
        stdstore
            .target(address(USDC)) // DAI Address ( Main Network )
            .sig(IERC20(address(USDC)).balanceOf.selector)
            .with_key(address(testContract))
            .checked_write(1000 * 1e18);
    }

    function testTokenBalances() public {
        uint256 balanceDai = testContract.getBalanceDai();
        uint256 balanceUsdc = testContract.getBalanceUsdc();
        assertEq(balanceDai, 1000000000000000000000); // Expect to have 1000 Dai
        assertEq(balanceUsdc, 1000000000000000000000); // Expect to have 1000 Dai

    }

    function testRouter() public {
        address routerAddress = testContract.getRouter();
        assertEq(routerAddress, address(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D));
    }



    function testSwap() public { // TRANSFER_FROM_FAILED ( Prob because calling from external contract )
        // List of token address to swap
        address[] memory s_tokens = new address[](2);
        s_tokens[0] = address(USDC); // Add some logs here
        s_tokens[1] = address(DAI);
        uint[] memory test = 
        testContract.swap(  
            3, // Amount In
            2, // Amount Out Min
            s_tokens, // Path (DAI > USDC)
            address(this), // This address
            block.timestamp + 1 minutes // Deadline
        );
    }

    /*
    function testAmountsOut() public {
        address[2] memory s_path = [DAI, USDC];
    }
    */
}
