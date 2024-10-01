

#ifndef ATM_H
#define ATM_H
#include "Screen.h" 
#include "Keypad.h" 
#include "CashDispenser.h" 
#include "DepositSlot.h" 
#include "BankDatabase.h" 
class Transaction; 
class ATM
{
public:
 ATM(); 
 void run(); 
private:
 bool userAuthenticated; //�����֤�Ƿ�ͨ��
 int currentAccountNumber; 
 Screen screen; 
 Keypad keypad; 
 CashDispenser cashDispenser; 
 DepositSlot depositSlot; 
 BankDatabase bankDatabase; 
 
 void authenticateUser(); //��֤���
 void performTransactions(); 
 int displayMainMenu() const; 
 
 Transaction *createTransaction(int); 
}; 
#endif 