// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

contract StakingContract { 
    mapping(address => uint) stakes;
    uint public totalStake; 
    mapping(address => uint) lastTimeupdate; 
    mapping(address => uint) unclaimedReward; 

     
    address owner;


    constructor(address _owner) {
       
        owner = _owner; 
        //owner address. 
    }
    function stake() public payable {
        require(msg.value > 0); // should also have the condition that the user has the balance > msg.value
        if(lastTimeupdate[msg.sender] ==0 ) {
            lastTimeupdate[msg.sender] = block.timestamp; 
        } else{
          unclaimedReward[msg.sender] += (block.timestamp - lastTimeupdate[msg.sender]) * balanceOf(msg.sender); 
            lastTimeupdate[msg.sender] = block.timestamp;
            

        }
        
        stakes[msg.sender] += msg.value; 
        totalStake += msg.value; 

    }
    function unstake(uint _amount) public  {
        require(stakes[msg.sender] >= _amount);
        payable(address(msg.sender)).transfer(_amount); 
        totalStake -= _amount; 
        stakes[msg.sender] -= _amount; 
    }
     function balanceOf(address account) public view returns (uint256) {
        return stakes[account];
    }
    function getRewards(address user) public view returns (uint) {
        uint updateTime = lastTimeupdate[user]; 
        uint currentReward = unclaimedReward[user]; 
        // calculate the reward when lastTimeupdate means, when claimed or stake or unstake 
        uint newReward = (block.timestamp - updateTime) * balanceOf(user); 
        return  currentReward + newReward; 


    }
    function claimRewards() public {
        uint currentReward = unclaimedReward[msg.sender];
        uint updateTime = lastTimeupdate[msg.sender]; 
        uint newReward = (block.timestamp - updateTime) * balanceOf(msg.sender); 
        unclaimedReward[msg.sender] += newReward; 
        // transfer currentReward + newReward getunclaimedReward[msg.sender] ORCA tokens 
        unclaimedReward[msg.sender] = 0; 
        lastTimeupdate[msg.sender] = block.timestamp; // now your interest rate calculation with this time of block





    }
}


