#include "ATM.h" 
#include "Transaction.h" 
#include "BalanceInquiry.h"
#include "Withdrawal.h"
#include "Deposit.h"
enum MenuOption { BALANCE_INQUIRY = 1, WITHDRAWAL, DEPOSIT, EXIT };

ATM::ATM() 
 : userAuthenticated (false), 
 currentAccountNumber(0) 
{ 
} 

void ATM::run()
{
 
  while (true)
  {
 
       while (!userAuthenticated) 
      {
      screen.displayMessageLine("\n��ӭ����atm�� "); 
        authenticateUser();// ��֤���
       } 
 
         performTransactions(); 
          userAuthenticated = false; 
          currentAccountNumber = 0; 
       screen.displayMessageLine("\n��ӭʹ��");
  } 
      } 

void ATM::authenticateUser() 
{
     screen.displayMessage("\n����������˺�: ");
     int accountNumber = keypad.receiveinput (); 
     screen.displayMessage("\n����������: "); 
     int pin = keypad.receiveinput (); 
 
 
       userAuthenticated = bankDatabase.authenticateUser(accountNumber, pin);
 
 
      if (userAuthenticated)
        {
         currentAccountNumber = accountNumber; 
      } 
        else
        screen.displayMessageLine("��������˺Ŵ�������������");
} 

void ATM::performTransactions() 
{
 
   Transaction *currentTransaction; // �洢��ǰ���ڴ���Ľ���
 
      bool userExited = false; 
   
        while (!userExited)
         { 
 
          int mainMenuSelection = displayMainMenu();
 
          switch (mainMenuSelection)
          {
 
           case BALANCE_INQUIRY: 
          case WITHDRAWAL: 
           case DEPOSIT:
 
           currentTransaction = createTransaction(mainMenuSelection);
          currentTransaction->execute(); 
 
           delete currentTransaction;
               break; 
            case EXIT: 
              screen.displayMessageLine("\n�رս���...");
            userExited = true; 
             break;
             default: 
               screen.displayMessageLine("\n�����������������");
             break;
             } 
            } 
} 

int ATM::displayMainMenu() const
{
 screen.displayMessageLine("\n����:");
 screen.displayMessageLine("1. �鿴���");
 screen.displayMessageLine("2. ȡ�� ");
 screen.displayMessageLine("3. ��� ");
 screen.displayMessageLine("4. �˳�\n");
 screen.displayMessage("�������������: ");
 return keypad.receiveinput (); 
} 
 

Transaction *ATM::createTransaction(int number)
{
 Transaction *tempPtr; 
 
 switch (number)
 {
 case BALANCE_INQUIRY: 
 tempPtr = new BalanceInquiry(
 currentAccountNumber, screen, bankDatabase);
 break;
 case WITHDRAWAL: 
 tempPtr = new Withdrawal(currentAccountNumber, screen, 
 bankDatabase, keypad, cashDispenser);
 break; 
 case DEPOSIT: 
 tempPtr = new Deposit(currentAccountNumber, screen, 
 bankDatabase, keypad, depositSlot);
 break;
 } 
 return tempPtr; 
} 