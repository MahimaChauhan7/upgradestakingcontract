// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13; 
import "forge-std/Test.sol"; 
import "src/OrcaCoin.sol"; 
import "src/Staking.sol";

contract Stake is Test {
    StakingContract stakeit;  
    function setUp() public {
        stakeit = new StakingContract(address(this)); 

    }
    function test_Unstake() public {
        stakeit.stake{value: 200}();
        stakeit.unstake(100);
        assert(stakeit.balanceOf(address(this)) == 100);

    }
    function test_FailUnstake() public {
        stakeit.stake{value: 200}();
        stakeit.unstake(300);
    }
}