// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13; 
import "forge-std/Test.sol"; 
import "src/OrcaCoin.sol"; 
contract OrcaCinTest is Test {
    OrcaCoin orcaCoin; 
    function setUp() public {
        orcaCoin = new OrcaCoin(address(this)); 

    }
    function testInitialSupply() public {
        assert(orcaCoin.totalSupply() == 0 );

    }
    function testFailmint() public {
        vm.startPrank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 );
        orcaCoin.mint(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 , 10);
        vm.stopPrank();
    }
    function testMint() public {
        orcaCoin.mint(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 , 10);
        assert(orcaCoin.balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266) == 10);
    }
    function testChangeStakingContract() public {
        orcaCoin.updateStakingContract(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 );
        vm.startPrank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 );
        orcaCoin.mint(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, 10 ); 
        assert(orcaCoin.balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266) == 10);

    }
}


