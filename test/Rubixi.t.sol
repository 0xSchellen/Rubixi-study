pragma solidity ^0.8.13;

import {stdStorage, StdStorage, Test} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";
import {console} from "../src/Console.sol";
import {Rubixi} from "../src/Rubixi.sol";

contract RubixiTest is Test {
    Rubixi public rubixi;
    address private alice;
    address private wallet;
    uint private valor;
    string private descricao;

    function setUp() public {
        rubixi = new Rubixi();
        wallet = address(rubixi);
        alice = address(0x01);

        vm.label(address(alice), "Alice");
        //vm.label(address(rubixi), "Rubixi");
        vm.label(wallet, "Wallet");

        vm.deal(alice, 2e18);
        vm.deal(wallet, 4e18);

        vm.startPrank(alice);
        rubixi.changeFeePercentage(20);
        rubixi.changeMultiplier(150);
        rubixi.currentMultiplier();
        rubixi.currentFeePercentage();
        rubixi.currentPyramidBalanceApproximately();
        //console.log(valor);
        vm.stopPrank();

    }

    function testInitialEther() public {
        assertEq(address(rubixi).balance, 4e18);
        assertEq(alice.balance, 2e18);        
    }

    function testDynamicPyramid() public {
        vm.startPrank(alice);
        rubixi.DynamicPyramid();
        //rubixi.creator();
        vm.stopPrank();
        assertEq(rubixi.creator(), address(alice));
    }

    function testSendEtherToRubixi() public {
        vm.startPrank(alice);
        assertEq(alice.balance, 2e18);

        payable(wallet).transfer(0.5e18);

        //(bool sent, bytes memory data) = address(rubixi).call{value: 1.1e18}("");
        //require(sent, "Failed to send Ether");
        //assertEq(sent, true);

        //assertEq(wallet.balance, 5.1e18);
        assertEq(alice.balance, 2e18);
        //alice.balance;  
        //rubixi.creator();
        vm.stopPrank();
        //assertEq(rubixi.creator(), address(alice));
    }

}

// 1000000000000000000
// 5000000000000000000
// 4000000000000000000
// 1100000000000000000