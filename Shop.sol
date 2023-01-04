// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Token.sol";

contract ICOShop is Ownable { 

    CreativeCoin public token; 
    uint public rate; 

    constructor ( uint tokenAmount , uint rateAmount ) { 
        createTokenForSell(tokenAmount);
        changeOwnerToken(msg.sender);
        rate = rateAmount; 

    }

    // function that will deploy our token
    function createTokenForSell ( uint _valueTokenForSale ) internal onlyOwner {
        CreativeCoin newCreativeCoin = new CreativeCoin(_valueTokenForSale);
        token = CreativeCoin(address(newCreativeCoin));
    }

    //change Owner Function 
    function changeOwnerToken ( address _newOwner ) internal onlyOwner { 
        token.transferOwnership(_newOwner );
    }


    // get token balance on this contract 
    function tokenBalance () public  view returns ( uint ) { 
        return token.balanceOf(address(this));
    }
    // get this contract balance eher 
    function etherBalance () public view returns ( uint ) { 
        return address(this).balance;
    }
    // new address token function 
    function newToken ( address _adr ) external  onlyOwner { 
        require(_adr != address(0) , "Zerro Address!");
        token = CreativeCoin(_adr);
    }
    // new Rate function
    function newRate ( uint amount )  external onlyOwner { 
        require(amount > 0 , "Rejected with 0 amount ");
        rate = amount;
    }
    //func withdraw all tokens if they are not selling 
    function tokenWithdraw () external onlyOwner { 
        require( tokenBalance() > 0 , " 0 amount of tokenBalance ");
        token.transfer(owner(), tokenBalance());
    }
    //func withdraw etherum from contract 
    function etherWithdrwaw () external onlyOwner { 
        require( address(this).balance > 0 , " 0 amount of contract balance ");
        payable(owner()).transfer(address(this).balance);
    }
    //buyToken Funciton 
    function buyToken () external payable {
        require(msg.value > 0 , " Rejected ");
        uint tokensAmount = msg.value / rate; 
        require( tokensAmount <= tokenBalance (), " Rejected " );
        token.transfer(msg.sender, tokensAmount);
    }
    //sellToken Function
    function sellToken ( uint _tokenAmount ) external { 
        uint allowanceToken = token.allowance(msg.sender, address(this));
        uint etheramount = _tokenAmount * rate; 
        require( allowanceToken >= _tokenAmount, "rejected "); 
        token.transferFrom(msg.sender , address(this), _tokenAmount);
        payable(msg.sender).transfer(etheramount);
    }

}

// Create Token Here - https://wizard.openzeppelin.com/
// Remix IDE - https://remix.ethereum.org/
// Ethereum Converter - https://eth-converter.com/



