

#ifndef TRANSACTION_H
#define TRANSACTION_H
class Screen; 
class BankDatabase; 
class Transaction
{
public:
 
 Transaction(int, Screen &, BankDatabase &);
 virtual ~Transaction() { }//析构函数 
 int getAccountNumber() const; 
 Screen &getScreen() const; 
 BankDatabase &getBankDatabase() const; 
 
 virtual void execute() = 0; //这个函数在派生类中会被重写
private:
 int accountNumber; 
 Screen &screen; 
 BankDatabase &bankDatabase; 
}; 
#endif 