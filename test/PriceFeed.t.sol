pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/PriceFeed.sol";
import "../interfaces/IERC20.sol";

contract PriceFeedTest is Test {

    using stdStorage for StdStorage;
    PriceFeed public priceFeed;

    address public constant LINK = 0x514910771AF9Ca656af840dff83E8264EcF986CA;

    function setUp() public {
        priceFeed = new PriceFeed();
        stdstore
        .target(address(LINK))
        .sig(IERC20(address(LINK)).balanceOf.selector)
        .with_key(address(priceFeed))
        .checked_write(1000 * 1e18);
    }

    function testEthUsdPriceFeed() public {
        int price  = priceFeed.getLatestEthUsdPrice();
        assertEq(price, 1);
    }
}