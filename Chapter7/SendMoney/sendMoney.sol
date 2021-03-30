 pragma solidity ^0.5.11;
 contract SendMoney {
     
     uint public balancerecived;
     function recivemoney () public payable{
         balancerecived += msg.value;
     }
     
     function getbalance () public view returns (uint) {
         return address(this).balance;
     }
     
     function withdrawmoney () public {
         address payable to = msg.sender;
         
         to.transfer (this.getbalance()); 
     }
     
     function withdrawmoneyto (address payable _to) public{
         _to.transfer(this.getbalance());
     }
 }