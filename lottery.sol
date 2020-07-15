pragma solidity ^0.4.17;

contract Lottery {
    //Create an address-typed variable for the manager with public visibility
    //P.S.: Public or Private has no implications on security themselves.
    address public manager;
    
    function Lottery() public {
        //Use msg.sender to get the address of the account invoking the contract
        manager = msg.sender;
    }
}