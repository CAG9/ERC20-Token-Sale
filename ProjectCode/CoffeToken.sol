// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract CoffeToken is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    event CoffePurchased(address indexed receiver, address indexed buyer);

    constructor() ERC20("CoffeToken", "CFE") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount * 10 ** decimals() );
    }

    function buyOneCoffe() public{
        _burn(_msgSender(), 1 * 10 ** decimals());
        emit CoffePurchased(_msgSender(),_msgSender());
    }

    function buyOneCoffeFrom(address account) public{
        _spendAllowance(account, _msgSender(), 1 * 10 ** decimals() );
        _burn(account, 1 * 10 ** decimals());
        emit CoffePurchased(_msgSender(), account);
    }

}
