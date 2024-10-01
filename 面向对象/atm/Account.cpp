#include "Account.h" 
Account::Account(int theAccountNumber, int thePIN, 
 double theAvailableBalance, double theTotalBalance)
 : accountNumber(theAccountNumber),
 pin(thePIN),
 availableBalance(theAvailableBalance),
 totalBalance(theTotalBalance)
{
} 

bool Account::validatePIN(int userPIN) const//��֤�����Ƿ���ȷ
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
void Account::debit(double amount)//ȡǮ
{
 availableBalance -= amount; 
 totalBalance -= amount; 
} 
void Account::credit(double amount)//��Ǯ
{
 totalBalance += amount; 
} 

int Account::getAccountNumber() const
{
 return accountNumber; 
} 