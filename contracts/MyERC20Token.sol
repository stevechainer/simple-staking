// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
  
  
contract MyERC20Token is ERC20 {
    uint256 private _initialSupply = 10_000_000;

    constructor (string memory _name, string memory _symbol) ERC20(_name, _symbol) {
        _mint(msg.sender, _initialSupply * (10 ** decimals()));
        // Additional initialization can be done here
    }

    function decimals() public view virtual override returns (uint8) {
        return 6;
    }
}