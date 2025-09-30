// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Staking.sol";

contract StakingContractTest is Test {
    StakingContract stakingContract;

    // Allow the contract to receive ETH
    receive() external payable {}

    function setUp() public {
        stakingContract = new StakingContract(address(this));
    }

    function testStake() public {
        stakingContract.stake{value: 200}();
        assert(stakingContract.balanceOf(address(this)) == 200);
    }

    function testStakeUser() public {
        vm.startPrank(0xfF1D73Ea47222386fE482BAadb1f3d5755ea55c9);
        vm.deal(0xfF1D73Ea47222386fE482BAadb1f3d5755ea55c9, 10 ether);
        stakingContract.stake{value: 1 ether}();
        assert(stakingContract.balanceOf(0xfF1D73Ea47222386fE482BAadb1f3d5755ea55c9) == 1 ether);
    }

    function testUnstake() public {
        stakingContract.stake{value: 200}();
        stakingContract.unstake(100);
        assert(stakingContract.balanceOf(address(this)) == 100);
    }

    function test_RevertWhen_UnstakeMoreThanBalance() public {
        stakingContract.stake{value: 200}();
        vm.expectRevert();
        stakingContract.unstake(300);
    }
}
