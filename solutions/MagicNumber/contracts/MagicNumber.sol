// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "hardhat/console.sol";

interface Solver {
    function whatIsTheMeaningOfLife() external view returns (bytes32);
}

contract MagicNumber{

    function validate(address  _instance) public view returns (bool) {

        // Retrieve the solver from the instance.
        Solver solver = Solver(_instance);
        console.log("solver:%s", address(solver));
        // Query the solver for the magic number.
        bytes32 magic = solver.whatIsTheMeaningOfLife();
        if(magic != 0x000000000000000000000000000000000000000000000000000000000000002a) return false;
        console.logBytes32(magic);

        // Require the solver to have at most 10 opcodes.
        uint256 size;
        assembly {
            size := extcodesize(_instance)
        }
        console.log("size=:%s", size);
        if(size > 10) return false;

        return true;
    }
}