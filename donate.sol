//SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

contract Trust {

    // This will only send money to one kid
    // The public key means that you can read the variable outside the smart contract 

    //  address public kid;
    //  uint256 public maturity;

     //constructor function is only called after you deploy the smart contract
     //payable will help you send ether to the smart contract

    //  constructor(address _kid, uint timeToMaturity) payable {
    //     maturity = block.timestamp + timeToMaturity;
    //     kid = _kid;
    //  }

        //eternal function will help the functions to be called outside the smart contract
    // '>=' meaning is superior

    //  function withdraw() external {
    //      require(block.timestamp >= maturity, 'too early');
    //      //the address should only be for the kid
    //      require(msg.sender == kid, 'only kid can withdraw');
    //      //sending money to the kid
    //      payable(msg.sender).transfer(address(this).balance); 
    //  }

    struct Kid {
        uint256 amount;
        uint256 maturity;
        bool paid;
    }
    mapping(address => Kid) public kids;
    //using mapping to send money to many kid
    // mapping(address => uint256) public amounts;
    // mapping(address => uint256) public maturities;
    // mapping(address => bool) public paid;

   //the admin to monitor the transaction of the kids
    address public admin;

    constructor() {
        admin = msg.sender;
        //the admin function is passed inside the addkid() function
    }

     function addKid(address kid, uint256 timeToMaturity) external payable {
         require(msg.sender == admin, 'only admin accesse');
        //   require(amounts[msg.sender] == 0, 'kid already exist');

         require(kids[msg.sender].amount == 0, 'kid already exist');
         kids[kid] = Kid(msg.value, block.timestamp + timeToMaturity, false);
    
         //msg.value is the amount of ether
        //  amounts[kid] = msg.value;
        //  maturities[kid] = block.timestamp + timeToMaturity;
     }

     function withdraw() external {
         Kid storage kid = kids[msg.sender];
         require(kid.maturity <= block.timestamp, 'too early');
        //  require(maturities[msg.sender] <= block.timestamp, 'too early');
        //  require(amounts[msg.sender] > 0, 'only kid can withdraw');
        require(kid.amount > 0, 'only kid can withdraw');
        //  require(paid[msg.sender] == false, 'you have paif already');
        require(kid.paid == false, 'you have paif already');
        //  paid[msg.sender] = true;
        kid.paid = true;
        //  payable(msg.sender).transfer(amounts[msg.sender]); 
         payable(msg.sender).transfer(kid.amount); 
     }
} 
