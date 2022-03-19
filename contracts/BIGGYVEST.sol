// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract BIGGVEST is Ownable{

    
    constructor(address _BIGGYTOKEN){
        BIGGYTOKEN = IERC20(_BIGGYTOKEN);
        admin = msg.sender;
    }

    address private admin;
    IERC20 public BIGGYTOKEN;
    address[] public s_allowedTokens;
    mapping(address=>mapping (address => uint)) public stakingbalance;

    
    function stakeToken( uint amount, address token) public {
        require(amount > 0, "you cannot stake zero sir");
        require(tokenIsAllowed(token), "only BIGGYTOKEN allowed");
        IERC20(token).transferFrom(msg.sender, address(this), amount);
        stakingbalance[token][msg.sender] = stakingbalance[token][msg.sender] + amount;
    }
    function addAllowedToken(address token) onlyOwner public  {
        s_allowedTokens.push(token);
    }
    function tokenIsAllowed(address token) public view returns(bool){
        for(uint i=0; i < s_allowedTokens.length; i++){
            if(s_allowedTokens[i] == token ) {
                return true;
            }
        }
        return false;
    }

       

   
   
   
    
}