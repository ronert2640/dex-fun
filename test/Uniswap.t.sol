pragma solidity >=0.5.0;

import "forge-std/Test.Sol";
import "../src/Uniswap.sol";
import "../interfaces/IERC20.sol";
//import "@openzepp"


contract UniswapTestTester is Test {

    using stdStorage for StdStorage;
    Uniswap public testContract;

    address public constant AAVE = 0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9;
    address public constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address public constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;


    event LogAmounts(uint[] _amounts);

    function setUp() public {
        testContract = new Uniswap();
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

        stdstore
            .target(address(AAVE)) // DAI Address ( Main Network )
            .sig(IERC20(address(USDC)).balanceOf.selector)
            .with_key(address(testContract))
            .checked_write(1000 * 1e18);
    }

    function testTokenBalances() public {
        uint256 balanceDai = testContract.getBalanceDai();
        uint256 balanceUsdc = testContract.getBalanceUsdc();
        assertEq(balanceDai, 1000000000000000000000); // Expect to have 1000 Dai
        assertEq(balanceUsdc, 1000000000000000000000); // Expect to have 1000 USDC

    }

    function testRouter() public {
        address routerAddress = testContract.getRouter();
        assertEq(routerAddress, address(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D));
    }



    function testSwapUsdcToDai() public {  
        // List of token address to swap
        address[] memory s_tokens = new address[](2);
        s_tokens[0] = address(USDC); // Add some logs here
        s_tokens[1] = address(DAI);
        testContract.swapUsdcToDai(  
            10000, // Amount In
            1000, // Amount Out Min
            s_tokens, // Path [USDC, DAI]
            address(this), // This address
            block.timestamp + 1 minutes // Deadline
        );
    }

    // Calculate Optimal token amounts before calling Swap()
    function testAmountsOutAaveToUsdc() public {
        address[] memory s_tokens = new address[](2);
        s_tokens[0] = address(AAVE); // Add some logs here
        s_tokens[1] = address(USDC);
        uint amounts = testContract.getAmountOut((1 * 1e18), s_tokens);
        assertEq(amounts, 1);
    }


    function testTokenBalancesAfterSwap() public {
        address[] memory s_tokens = new address[](2);
        s_tokens[0] = address(USDC); // Add some logs here
        s_tokens[1] = address(DAI);
        testContract.swapUsdcToDai(  
            10000, // Amount In
            1000, // Amount Out Min
            s_tokens, // Path [USDC, DAI]
            address(this), // This address
            block.timestamp + 1 minutes // Deadline
        );
        uint256 balanceDai = testContract.getBalanceDai();
        uint256 balanceUsdc = testContract.getBalanceUsdc();
        assertEq(balanceDai, 100000000000000000000); // Expect to have 1000 Dai
        assertEq(balanceUsdc, 100000000000000000000); // Expect to have 1000 USDC

    }

}
