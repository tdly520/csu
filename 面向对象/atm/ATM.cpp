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
      screen.displayMessageLine("\n欢迎来到atm机 "); 
        authenticateUser();// 验证身份
       } 
 
         performTransactions(); 
          userAuthenticated = false; 
          currentAccountNumber = 0; 
       screen.displayMessageLine("\n欢迎使用");
  } 
      } 

void ATM::authenticateUser() 
{
     screen.displayMessage("\n请输入你的账号: ");
     int accountNumber = keypad.receiveinput (); 
     screen.displayMessage("\n请输入密码: "); 
     int pin = keypad.receiveinput (); 
 
 
       userAuthenticated = bankDatabase.authenticateUser(accountNumber, pin);
 
 
      if (userAuthenticated)
        {
         currentAccountNumber = accountNumber; 
      } 
        else
        screen.displayMessageLine("密码或者账号错误，请重新输入");
} 

void ATM::performTransactions() 
{
 
   Transaction *currentTransaction; // 存储当前正在处理的交易
 
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
              screen.displayMessageLine("\n关闭交易...");
            userExited = true; 
             break;
             default: 
               screen.displayMessageLine("\n输入错误，请重新输入");
             break;
             } 
            } 
} 

int ATM::displayMainMenu() const
{
 screen.displayMessageLine("\n功能:");
 screen.displayMessageLine("1. 查看余额");
 screen.displayMessageLine("2. 取款 ");
 screen.displayMessageLine("3. 存款 ");
 screen.displayMessageLine("4. 退出\n");
 screen.displayMessage("请输入操作数字: ");
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