// SPDX-License-Identifier: MIT
// Create Token Here - https://wizard.openzeppelin.com/
// Remix IDE - https://remix.ethereum.org/
// Ethereum Converter - https://eth-converter.com/


pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Token.sol";

contract ICOShop is Ownable { 

    // here we created a 
    CreativeCoin public token; 
    uint public rate; 

    constructor (uint tokenAmount, uint rateAmount){
        changeOwner(msg.sender);
        createTokenForSell(tokenAmount);
        rate = rateAmount;
        
    }

    function createTokenForSell(uint _valueTokenForSell ) internal onlyOwner {
        CreativeCoin newCC  = new CreativeCoin(_valueTokenForSell);
        token = CreativeCoin(address(newCC));
    }

    // change the Owner function
    function changeOwner( address _newOwner) internal onlyOwner {
        // the tranferOwnership function comes from the Ownable library
        token.transferOwnership(_newOwner);
    }

    // new rate function
    function newrate (uint _newRate) external onlyOwner{
        require(_newRate > 0, " Cannot have a rate that is less than or equal to 0");
        rate = _newRate;
    }

    // new address token function
    function newToken (address _adr ) external onlyOwner {
        require( _adr != address(0), "zero address !!");
        token = CreativeCoin(_adr);
    }

    // funciton to withdraw all token if they are not selling
    function tokenWithdraw() external onlyOwner{
        require(tokenBalance() > 0, "TokenBalance is 0");
        token.transfer( owner(), tokenBalance());
    }

    // function to withdraw ethereum from the contract
    function tokenBalance() public view returns(uint){
       return token.balanceOf(address(this));
    }

}
