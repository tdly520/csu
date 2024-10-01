#ifndef BANK_DATABASE_H
#define BANK_DATABASE_H
#include <vector> //ʹ������ȥ�洢�˻���Ϣ
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
 vector< Account > accounts; //�洢�˻����룬�����Ϣ
 
 Account * getAccount(int); 
}; 
#endif 