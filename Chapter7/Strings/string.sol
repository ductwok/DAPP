 pragma solidity ^0.5.11;
  contract Workingwithvariable{
     uint256 public myUint;
     
     function setMyUint (uint _myUint)public{
      myUint= _myUint;   
     }
     
     bool public mybool;
     function setMybool (bool _mybool) public{
         mybool = _mybool;
     }
     
     uint8 public myUint8;
     function incrementuint() public{
         myUint8++;
     }
     
     function decrementuint () public{
         myUint8--;
     }
     
     address public myaddress;
     function setaddress (address _myaddress) public{
         myaddress = _myaddress;
     }
     
     function getBalanceofaddress () public view returns (uint){
         return myaddress.balance;
     }
     
     string public mystring = "hello hello hello!!!!!!!!!";
     
     function setmystring (string memory _mystring) public {
         mystring = _mystring;
     }
 }