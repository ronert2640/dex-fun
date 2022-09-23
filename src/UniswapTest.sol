pragma solidity >=0.5.0;

import "v2-periphery/libraries/UniswapV2Library.sol"; // This is a bug w/ Foundry... (The filepath should include /contracts/ ) ( Will adjust remapping )
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

    function swap(
        uint _amountOut, 
        uint _amountInMax, 
        address[] memory _path,
        address _to, 
        uint _deadline
    ) public {
        uint[] memory amounts = router.swapTokensForExactTokens(_amountOut, _amountInMax, _path, _to, _deadline);
    }


    function getAmountOut(
        uint _amountIn, 
        address[] memory s_path // list of token addresses
    ) public returns (uint) {
        //uint[] memory amountOut = UniswapV2Library.getAmountsOut(_amountIn, s_path);
        //return amountOut;
    }


    function getBalance() public view returns (uint256) {
        uint256 balance = dai.balanceOf(address(this));
        return balance;
    }

    function getRouter() public view returns (address) {
        return address(router);
    }


}