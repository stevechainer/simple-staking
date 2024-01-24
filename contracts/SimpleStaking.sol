// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract ERC20Staking {
    using SafeERC20 for IERC20;

    IERC20 public immutable token;

    uint public immutable rewardsPerHour = 1000;
    uint public totalStaked = 0;

    constructor(IERC20 token_) {
        token = token_;
    }

    function totalRewards() internal view returns (uint) {
        return _totalRewards();
    }

    function _totalRewards() internal view returns (uint) {
        return token.balanceOf(address(this) - totalStaked);
    }
}
