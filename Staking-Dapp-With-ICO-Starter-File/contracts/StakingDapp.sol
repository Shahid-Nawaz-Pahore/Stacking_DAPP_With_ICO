//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
 
 contract StackingDapp is Ownable, ReentrancyGuard {

    using SafeERC20 from IERC20;
    struct UserInfo{}
    struct PoolInfo{}
    struct Notification{}
    uint decimals = 10^18;
    uint public poolCount;
    PoolInfo[] public poolInfo;

    mapping(address => uint256) public depositedTokens;
    mapping (uint256=> mapping(address => UserInfo)) public userInfo;
    Notification[] public notifications;
 

 }