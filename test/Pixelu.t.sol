// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {Pixelu} from "../src/Pixelu.sol";

contract CounterTest is Test {
    Pixelu public pixelu;

    function setUp() public {
        pixelu = new Pixelu(address(this));
    }

    function test_Name() public {
        assertEq(pixelu.name(), "Pixelu Studio");
    }

    function test_Symbol() public {
        assertEq(pixelu.symbol(), "PIXELU");
    }

    function test_Uri() public {
        pixelu.setUri("https://server.com/");
        assertEq(pixelu.tokenURI(100), "https://server.com/100");
    }

    function test_Mint() public {
        pixelu.mint(address(this), 0);

        assertEq(pixelu.balanceOf(address(this)), 1);
        assertEq(pixelu.ownerOf(0), address(this));
    }

    function test_MintBatch() public {
        address[] memory addresses = new address[](100);
        uint256[] memory ids = new uint256[](100);

        for (uint256 i; i < addresses.length; i++) {
            addresses[i] = address(this);
            ids[i] = i;
        }

        pixelu.mintBatch(addresses, ids);

        assertEq(pixelu.balanceOf(address(this)), 100);
        assertEq(pixelu.ownerOf(0), address(this));
        assertEq(pixelu.ownerOf(1), address(this));
    }
}
