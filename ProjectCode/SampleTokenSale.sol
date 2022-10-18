// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

/*
Abstract Contract is one which contains at least one function without any implementation.
 Such a contract is used as a base contract.
 Generally an abstract contract contains both implemented as well as abstract functions.
*/

abstract contract ERC20 {
    function transferFrom(address _from, address _to, uint256 _value) public virtual returns(bool success);
    function decimals() public virtual view returns(uint8);
}

contract TokenSale {
    uint public tokenPriceInWei = 1 ether;

    ERC20 public token;
    address public tokenOwner;

    constructor(address _token){
        tokenOwner = msg.sender;
        token = ERC20(_token);
    }

    function purchaseACoffee() public payable{
        require(msg.value >= tokenPriceInWei, "Noth enough money to sent");
        uint tokensToTransfer = msg.value / tokenPriceInWei;
        uint remainder = msg.value - tokensToTransfer * tokenPriceInWei;
        token.transferFrom(tokenOwner, msg.sender, tokensToTransfer * 10 ** token.decimals());
        payable(msg.sender).transfer(remainder);//send the rest of the money back
    }

}
