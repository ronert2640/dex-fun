pragma solidity ^0.8.17;

import "v2-periphery/contracts/libraries/UniswapV2Library.sol";
import "../interfaces/IERC20.sol";

interface IUniswapV2Router {
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
}

contract UniswapTest {

    address public constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address public constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

    IUniswapV2Router private router = IUniswapV2Router(address(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D)); // Router 02 Address


    IERC20 dai = IERC20(DAI);

/*
    function swap(
        uint _amountOut, 
        uint amountInMax, 
        address[] calldata _path,
        address to, 
        uint deadline
    ) public {
        uint[] memory = router.swapToken
    }

*/

    function getAmountOut(
        uint _amountIn, 
        uint reserveIn, 
        uint reserveOut
    ) public {
        uint amountOut = UniswapV2Library.getAmountOut(_amountIn, reserveIn, reserveOut);
    }


    function getBalance() public view returns (uint256) {
        uint256 balance = dai.balanceOf(address(this));
        return balance;
    }

    function getRouter() public view returns (address) {
        return address(router);
    }


}