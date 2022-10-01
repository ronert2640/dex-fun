pragma solidity ^0.8.17;

import "../interfaces/IAggregatorV3Interface.sol";

contract PriceFeed {
    IAggregatorV3Interface internal priceFeedEthUsd;

    constructor() {
        priceFeedEthUsd = 
        IAggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
    }

    function getLatestEthUsdPrice() public view returns (int) {
        (
            uint80 roundID,
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound

        ) = priceFeedEthUsd.latestRoundData();
        return price;
    }
}