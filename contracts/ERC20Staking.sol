// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

/**
 * @title SampleERC20
 * @dev Create a sample ERC20 standard token
 */
contract ERC20Staking {
    using SafeERC20 for IERC20;

    IERC20 public immutable token;
    uint public immutable rewardsPerHour = 1000; // 0.01%

    uint public totalStaked = 0;
    mapping(address => uint) public balanceOf; 
    mapping(address => uint) public lastUpdated;
    mapping(address => uint) public claimed;

    event Deposit(address address_, uint amount_);
    event Claim(address address_, uint amount);
    event Compound(address address_, uint amount_);
    event Withdraw(address address_, uint amount_);

    constructor(IERC20 token_) {
        token = token_;
    }
 
    function totalRewards() external view returns (uint) {
        return _totalRewards();
    }

    function _totalRewards() internal view returns (uint) {
        return token.balanceOf(address(this)) - totalStaked;
    }

    // User staking
    function deposit(uint amount_) external {
        _compound();
        token.safeTransferFrom (msg.sender, address(this), amount_);
        balanceOf[msg.sender] += amount_;
        lastUpdated[msg.sender] = block.timestamp;
        totalStaked += amount_;

        emit Deposit(msg.sender, amount_);
    }

    // Get rewards according to staking addresss
    function rewards(address address_) external  view returns (uint) {
        return _rewards(address_);
    }

    function _rewards(address address_) internal view returns (uint) {
        return (block.timestamp - lastUpdated[address_]) * balanceOf[address_] / (rewardsPerHour * 1 hours);
    }
    
    // User claim their rewards
    function claim() external  {
        uint amount = _rewards(msg.sender);
        token.safeTransfer(address(this), amount);
        claimed[msg.sender] += amount;
        lastUpdated[msg.sender] = block.timestamp;
        
        emit Claim(msg.sender, amount);
    }

    function compound() external {
        _compound();
    }

    function _compound() internal {
        uint amount = _rewards(msg.sender);
        // No transfer function called
        claimed[msg.sender] += amount;
        balanceOf[msg.sender] += amount;
        totalStaked += amount;
        lastUpdated[msg.sender] = block.timestamp;

        emit Compound(msg.sender, amount);
    }

    function withdraw(uint amount_) external {
        require(balanceOf[msg.sender] >= amount_, "Insufficient funds");

        _compound();
        token.safeTransfer(msg.sender, amount_);
        balanceOf[msg.sender] -= amount_;
        totalStaked -= amount_;

        emit Withdraw(msg.sender, amount_);

    }
    
}