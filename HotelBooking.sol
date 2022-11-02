// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.10;

contract Tapatap{

    event Occupy(address _occupant, uint value);

    enum Status{ Vacant, Occupied }
    Status public currentStatus;

    address payable public hotelOwner;

    modifier costs(uint _amount){
        require(msg.value>=_amount,"Not enough, The amount needed is 2 ether");
        _;
    } 

    modifier onlyIfVacant{
        require(currentStatus==Status.Vacant, "The hotel is booked");
        _;
    }

    constructor(){
        hotelOwner=payable(msg.sender);
        currentStatus=Status.Vacant;
    }

    function book() public payable onlyIfVacant costs(2 ether) {
        (bool sent, bytes memory data) = hotelOwner.call{value: msg.value}("Not");
        require(true);
        currentStatus=Status.Occupied;
        emit Occupy(msg.sender, msg.value);
    }

}
