
 pragma solidity ^0.5.11;
 contract MappingStruct {
     
     mapping (address => uint) public balanceReceived;
     
     function getbalance () public view returns(uint) {
         return address(this).balance;
     }
     
     function sendmoney () public payable{
         balanceReceived[msg.sender] +=msg.value;
     }
     
     function withdrawallmoney (address payable _to) public {
         uint balancetoSend = balanceReceived[msg.sender];
         balanceReceived[msg.sender]=0;
         _to.transfer(address(this).balance);
     }
     function withdrawmoney (address payable _to, uint _amount ) public {
         require (balanceReceived[msg.sender]>= _amount, "not enough funds");
         balanceReceived[msg.sender] -= _amount;
         _to.transfer(_amount);
     } 
 }
