

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
 bool userAuthenticated; //身份验证是否通过
 int currentAccountNumber; 
 Screen screen; 
 Keypad keypad; 
 CashDispenser cashDispenser; 
 DepositSlot depositSlot; 
 BankDatabase bankDatabase; 
 
 void authenticateUser(); //验证身份
 void performTransactions(); 
 int displayMainMenu() const; 
 
 Transaction *createTransaction(int); 
}; 
#endif 