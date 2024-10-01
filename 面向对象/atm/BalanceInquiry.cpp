#include "BalanceInquiry.h" 
#include "Screen.h" 
#include "BankDatabase.h" 

BalanceInquiry:: BalanceInquiry(int userAccountNumber, Screen &atmScreen, 
 BankDatabase &atmBankDatabase)
 : Transaction(userAccountNumber, atmScreen, atmBankDatabase)
{
 
} 

void BalanceInquiry::execute()
{
 
    BankDatabase &bankDatabase = getBankDatabase();
    Screen &screen = getScreen();
    double availableBalance = 
    bankDatabase.getAvailableBalance(getAccountNumber());
    double totalBalance = 
    bankDatabase.getTotalBalance(getAccountNumber());
     screen.displayMessageLine("\n余额明细:");
     screen.displayMessage(" 可用余额 "); 
     screen.displayAmount(availableBalance);
     screen.displayMessage("\n 总共余额: ");
     screen.displayAmount(totalBalance);
     screen.displayMessageLine("");
} 