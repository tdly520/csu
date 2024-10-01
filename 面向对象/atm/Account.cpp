#include "Account.h" 
Account::Account(int theAccountNumber, int thePIN, 
 double theAvailableBalance, double theTotalBalance)
 : accountNumber(theAccountNumber),
 pin(thePIN),
 availableBalance(theAvailableBalance),
 totalBalance(theTotalBalance)
{
} 

bool Account::validatePIN(int userPIN) const//验证密码是否正确
{ 
 if (userPIN == pin)
 return true;
 else
 return false;
} 

double Account::getAvailableBalance() const
{
 return availableBalance;
} 

double Account::getTotalBalance() const
{
 return totalBalance;
} 
void Account::debit(double amount)//取钱
{
 availableBalance -= amount; 
 totalBalance -= amount; 
} 
void Account::credit(double amount)//存钱
{
 totalBalance += amount; 
} 

int Account::getAccountNumber() const
{
 return accountNumber; 
} 