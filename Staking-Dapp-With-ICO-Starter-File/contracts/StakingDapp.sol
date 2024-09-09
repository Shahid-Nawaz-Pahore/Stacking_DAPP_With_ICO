//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
 
 contract StackingDapp is Ownable, ReentrancyGuard {

    using SafeERC20 from IERC20;
    struct UserInfo{
        uint256 amount;
        uint lastRewardAt;
        uint256 lockUntil;
    }
    struct PoolInfo{
        IERC20 depositToken;
        IERC20 rewardToken;
        uint256 depositedAmount;
        uint256 apy;   //percentage
        uint lockDays; 
    }
    struct Notification{
        uint256 poolID;
        uint256 amount;
        address user;
        string typeOf;
        uint256 timestamp;
    }
    uint decimals = 10^18;
    uint public poolCount;
    PoolInfo[] public poolInfo;

    mapping(address => uint256) public depositedTokens;
    mapping (uint256=> mapping(address => UserInfo)) public userInfo;
    Notification[] public notifications;
 
    //CONTRACT FUNCTION
    function addPool(
        IERC20 _depositToken,
         IERC20 _rewardToken, 
         uint256 _apy, 
         uint _lockDays
         ) 
         public onlyOwner{

            poolInfo.push(PoolInfo({
                depositToken: _depositToken,
                rewardToken: _rewardToken,
                apy: _apy,
                lockDay: _lockDays,
            }));
            poolCount++;
         }
    function deposit(uint _pid, uint _amount) public nonReentrant{
        require(_amount > 0, "Amount should be greater then zero");
        //get poolInfo
        PoolInfo storage pool = poolInfo[_pid];
        //spacific pool which user is create
        UserInfo string user = userInfo[_pid][msg.sender];    


    if(user.amount > 0){
       uint pending = _createNotification(user, _pid)
       pool.rewardToken.transfer(msg.sender,pending);
       _createNotification(_pid,pending,msg.sender,"Claim");
    }
    pool.depositToken.transferFrom(msg.sender, address(this), _amount)
    pool.depositedAmount+=_amount;
    user.amount += _amount;
    user.lastRewardAt = block.timestamp;
    //user.lastRewardAt = block.timestamp + (pool.lockDays*86400)
    user.lockUntil = block.timestamp + (pool.lockDays*60);
    depositedTokens[address(pool.depositToken)] += _amount;
    _createNotification(_pid,_amount,msg.sender,"Deposit");
    }
    function withdraw() {}
    function _calcPendingReward() {}
    function pendingReward() {}
    function sweep() {}
    function modifyPool(){}
    function claimReward(){}
    function _createNotification() {}
    function getNotifications() {}


 }