// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/ParaSwap.sol";
import "../interfaces/IERC20.sol";

contract ParaSwapTest is Test {

    using stdStorage for StdStorage;
    ParaSwap public paraswap;

    address public constant AAVE = 0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9;
    
    function setUp() public {
        paraswap = new ParaSwap();
        stdstore
        .target(address(AAVE))
        .sig(IERC20(address(AAVE)).balanceOf.selector)
        .with_key(address(paraswap)) 
        .checked_write(1000 * 1e18);
    }

    function testBalance() public {
        uint256 aaveBalance = IERC20(AAVE).balanceOf(address(paraswap));
        assertEq(aaveBalance, (1000 * 1e18));
    }

    function testInitializeAllowance() public {
        uint256 daiAmount = (1 * 1e18);
        paraswap.initializeTransferAllowance(daiAmount);
    }

    function testViewTokenTransferProxy() public {
        address proxyAddress = paraswap.viewTokenTransferProxy();
        assertEq(proxyAddress, address(0x216B4B4Ba9F3e719726886d34a177484278Bfcae)); // Address take from etherscan
    }

    /*
    function testTransferTokenTo() public {
        uint256 aaveAmount = (1 * 1e18);
        paraswap.transferTokenTo(address(this), aaveAmount);
    }
    */
}