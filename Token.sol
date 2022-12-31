// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CreativeCoin is ERC20, Ownable {
    constructor(uint totalSupply) ERC20("CreativeCoin", "CC") {
        // my total supply will be what i will give it
        _mint(msg.sender, totalSupply * 10 ** decimals());
    }

    function decimals() public pure override returns (uint8){
        return 0;
    }
}

