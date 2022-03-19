// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BIGGYTOKEN is ERC20, Ownable {
    constructor() ERC20("BIGGY TOKEN", "BGT") {
        _mint(msg.sender, 1000 * 10**decimals());
        minter = msg.sender;
    }
    uint256 public tokensPerEth = 50;
    address public minter;
    event MinterChanged(address indexed from, address to);

    function passMinterRole(address BIGGYVEST) public returns (bool) {
        require(
            msg.sender == minter,
            "Error, only owner can change pass minter role"
        );
        minter = BIGGYVEST;

        emit MinterChanged(msg.sender, BIGGYVEST);
        return true;
    }

    function mint(address to, uint256 amount) public  {
        require(msg.sender==minter, 'Error, msg.sender does not have minter role'); 
        _mint(to, amount);
    }
     function buytoken(address receiver) public payable {
        require(msg.value > 0, "our tokens are 1000/eth boss");
        uint amount = msg.value * tokensPerEth;
        _mint(receiver, amount );
    }
    function modifyTokenBuyPrice( uint256 _tokensPerEth) public onlyOwner {
        tokensPerEth = _tokensPerEth;
    }


}
