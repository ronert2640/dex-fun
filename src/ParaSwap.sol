// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.5;

import "../interfaces/IERC20.sol";
import "../interfaces/IAugustusSwapper.sol";

interface ITokenTransferProxy {
    function transferFrom (
        address token,
        address from,
        address to,
        uint256 amount
    )
    external;
}

// Let's test w/ Aave > Dai & Vice Versa

contract ParaSwap {

    // Paraswap Mainnet addresses ( TokenTransferProxy address used for initial Approve() )
    // AugustusSwapper acts as a proxy contract for the other Routers.. passing calls to respective contract
    // See: https://developers.paraswap.network/smart-contracts/augustus-swapper

    address public constant AugustusSwapper = 0xDEF171Fe48CF0115B1d80b88dc8eAB59176FEe57;
    address public TokenTransferProxy;

    address public constant AAVE = 0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9;
    address public constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;

    constructor() {
        TokenTransferProxy = IAugustusSwapper(AugustusSwapper).getTokenTransferProxy();
    }

    function initializeTransferAllowance(uint256 _amount) public {
        // Sets ERC20 Approval to Proxy contract.
        IERC20(AAVE).approve(TokenTransferProxy, _amount);
    }




    function transferTokenTo(
        address _to,
        uint256 _amount
    ) public {
        /*
        IAugustusSwapper(AugustusSwapper).transferFrom(
            AAVE, 
            address(this), 
            _to, 
            _amount
        );
        */
    }

    function viewTokenTransferProxy() public view returns (address) {
        return TokenTransferProxy;
    }

}