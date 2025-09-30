// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract OrcaCoin is ERC20 {
    address stakingCorntract;
    address owner; // metamask or wallet address of the owner

    constructor(address _stakingContract) ERC20("Ord", "ORD") {
        stakingCorntract = _stakingContract;
        owner = msg.sender;
    }
    // Minting function

    function mint(address account, uint256 value) public {
        require(msg.sender == stakingCorntract);
        _mint(account, value);
    }

    function updateStakingContract(address _stakingContract) public {
        require(msg.sender == owner);
        stakingCorntract = _stakingContract;
    }
}
