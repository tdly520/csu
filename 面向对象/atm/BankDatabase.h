#ifndef BANK_DATABASE_H
#define BANK_DATABASE_H
#include <vector> //使用容器去存储账户信息
#include "Account.h" 
using namespace std;
class BankDatabase
{
public:
 BankDatabase(); 
 
 bool authenticateUser(int, int); 
 double getAvailableBalance(int); 
 double getTotalBalance(int); 
 void credit(int, double); 
 void debit(int, double); 
private:
 vector< Account > accounts; //存储账户密码，余额信息
 
 Account * getAccount(int); 
}; 
#endif 