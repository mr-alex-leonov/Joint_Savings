/*
Joint Savings Account
---------------------
*/
pragma solidity ^0.5.0;

// Define a new contract named `JointSavings`
contract JointSavings {

    address payable public accountOne;
    address payable public accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    /*
    Define a function named **withdraw**  accepting two arguments:
    - A `uint` variable named `amount`
    - A `payable address` named `recipient`
    */
    function withdraw(uint amount, address payable recipient) public {

        /*
        Define a `require` statement that checks if the `recipient` is equal to either `accountOne` or `accountTwo`. The `requiere` statement returns the text `"You don't own this account!"` if it does not.
        */
       
        require(recipient==accountOne || recipient == accountTwo, "You don't own this account!");

        /*
        Define a `require` statement that checks if the `balance` is sufficient to accomplish the withdraw operation. Return the text `Insufficient funds!`, if there are insufficient funds
        */
       
        require(address(this).balance >= amount, "Insufficient funds!");

        /*
        Add an `if` statement to check if the `lastToWithdraw` is not equal to (`!=`) to `recipient.` Set "If `lastToWithdraw` is not equal, then set it to the current value of `recipient`."
        */
       
        if (lastToWithdraw != recipient) {lastToWithdraw = recipient;}

        // Call the `transfer` function of the `recipient` and pass it the `amount` to transfer as an argument.
        
        recipient.transfer(amount);

        // Set  `lastWithdrawAmount` equal to `amount`
        
        lastWithdrawAmount = amount;

        // Call the `contractBalance` variable and set it equal to the balance of the contract by using `address(this).balance` to reflect the new balance of the contract.
        
        contractBalance = address(this).balance;
    }

    // Define a `public payable` function named `deposit`.
    function deposit() public payable {

        /*
        Call the `contractBalance` variable and set it equal to the balance of the contract by using `address(this).balance`.
        */
        
        contractBalance = address(this).balance;
    }

    /*
    Define a `public` function named `setAccounts` that receive two `address payable` arguments named `account1` and `account2`.
    */
    function setAccounts(address payable account1, address payable account2) public{

        // Set the values of `accountOne` and `accountTwo` to `account1` and `account2` respectively.
        
        accountOne = account1;
        accountTwo = account2;
    }

    /*
    Add the **default fallback function** so that the contract can store Ether sent from outside the deposit function.
    */
    
    function() external payable{}
}
