

#include "BankDatabase.h" 

BankDatabase::BankDatabase()
{
 
 Account account1(12345, 54321, 200.0, 2000.0);
  accounts.push_back(account1);
 Account account2(54321, 12345, 20.0, 200.0);

 accounts.push_back(account2); 
} 

Account * BankDatabase::getAccount(int accountNumber)
{
 
 for (size_t i = 0; i < accounts.size(); i++)
 {
 
 if (accounts[ i ].getAccountNumber() == accountNumber)
 return &accounts[ i ];
 } 
 return NULL; //如果没有找到返回NULL 
} 


bool BankDatabase::authenticateUser(int userAccountNumber, 
 int userPIN)
{
 
 Account * const userAccountPtr = getAccount(userAccountNumber);
 
 if (userAccountPtr != NULL)
 return userAccountPtr->validatePIN(userPIN);
 else
 return false; //没有找到账户返回false
} 

double BankDatabase::getAvailableBalance(int userAccountNumber)
{Account * const userAccountPtr = getAccount(userAccountNumber);
 return userAccountPtr->getAvailableBalance();
} 

double BankDatabase::getTotalBalance(int userAccountNumber)
{
 Account * const userAccountPtr = getAccount(userAccountNumber);
 return userAccountPtr->getTotalBalance();
} 

void BankDatabase::credit(int userAccountNumber, double amount)
{
 Account * const userAccountPtr = getAccount(userAccountNumber);
 userAccountPtr->credit(amount);
} 

void BankDatabase::debit(int userAccountNumber, double amount)
{
 Account * const userAccountPtr = getAccount(userAccountNumber);
 userAccountPtr->debit(amount);
} 