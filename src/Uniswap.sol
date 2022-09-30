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

    function getAmountsOut(
        uint256 amountIn, 
        address[] calldata path
    ) external view returns (uint256[] memory amounts);

}

contract Uniswap {

    address public constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address public constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address public constant AAVE = 0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9;


    address public constant UniswapRouter2 = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;

    event _Swap(uint[] path, address to);

    IUniswapV2Router private router = IUniswapV2Router(UniswapRouter2); // Router 02 Address


    IERC20 dai = IERC20(DAI);
    IERC20 usdc = IERC20(USDC);
    IERC20 aave = IERC20(AAVE);

    function swapUsdcToDai( 
        uint _amountIn, 
        uint _amountOutMin, 
        address[] memory _path,
        address _to, 
        uint _deadline
    ) public returns (uint[] memory) {
        // Approve ERC20 Token to Uniswap Router02 
        usdc.approve(UniswapRouter2, _amountIn);
        router.swapExactTokensForTokens( // Get amounts [USDC, DAI]
            _amountIn, 
            _amountOutMin, 
            _path, 
            _to, 
            _deadline
        );
        //emit _Swap(_path, _to);
    }


    function swapAaveToUsdc( 
        uint _amountIn, 
        uint _amountOutMin, 
        address[] memory _path,
        address _to, 
        uint _deadline
    ) public returns (uint[] memory) {
        // Approve ERC20 Token to Uniswap Router02 
        aave.approve(UniswapRouter2, _amountIn);
        router.swapExactTokensForTokens( // Get amounts [USDC, DAI]
            _amountIn, 
            _amountOutMin, 
            _path, 
            _to, 
            _deadline
        );
        //emit _Swap(_path, _to);
    }


    function getAmountsOut(
        uint _amountIn, 
        address[] memory s_path // list of token addresses
    ) public returns (uint) {
        uint[] memory amountOut = router.getAmountsOut(_amountIn, s_path);
        return amountOut[s_path.length - 1];
    }


    function getBalanceDai() public view returns (uint256) {
        uint256 balance = dai.balanceOf(address(this));
        return balance;
    }

    function getBalanceUsdc() public view returns (uint256) {
        uint256 balance = usdc.balanceOf(address(this));
        return balance;
    }

    function getBalanceAave() public view returns (uint256) {
        uint256 balance = aave.balanceOf(address(this));
        return balance;
    }

    function getRouter() public view returns (address) {
        return address(router);
    }


}