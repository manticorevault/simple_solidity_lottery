pragma solidity ^0.4.25;

contract Lottery {
    //Create an address-typed variable for the manager with public visibility
    //P.S.: Public or Private has no implications on security themselves.
    address public manager;

    //Create a dynamic array that only contains addresses (the playeres).
    address[] public players; 

    function lottery() public {
        //Use msg.sender to get the address of the account invoking the contract
        manager = msg.sender;
    }

    function enter() public payable {
        //Requires an amount of money to join the lottery
        require(msg.value > .01 ether);    
        
       //Add the person address to the player's array
       players.push(msg.sender);
    }
    
    //Create a helper function the help find the winner
    function random() private view returns (uint) {
        //Get the params and returns it as an uint
        return uint(keccak256(block.difficulty, now, players));
    }
    
    function pickWinner() public restricted {
        
        //Will get a number between 0 and the players.length
        uint index = random() % players.length;
        //Send all the of money in the contract to the winner`s address
        players[index].transfer(this.balance); 
        //Reset the players array to a new dynamic array, with initial size 0
        players = new address[](0);
    }
    
    // Using a modifier to require the manager. called in pickWinner.
    // modifier avoids repetitive logic
    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
    
    function getPlayers() public view returns (address[]) {
        return players;
    }
}