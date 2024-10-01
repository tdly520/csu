#include "Deposit.h" 
#include "Screen.h" 
#include "BankDatabase.h" 
#include "Keypad.h" 
#include "DepositSlot.h" 
static const int STOP = 0; 
Deposit::Deposit(int userAccountNumber, Screen &atmScreen, 
 BankDatabase &atmBankDatabase, Keypad &atmKeypad, 
 DepositSlot &atmDepositSlot)
 : Transaction(userAccountNumber, atmScreen, atmBankDatabase),
 keypad(atmKeypad), depositSlot(atmDepositSlot)
{
 
} 

void Deposit::execute()
{
 BankDatabase &bankDatabase = getBankDatabase(); 
 Screen &screen = getScreen(); 
 amount = getDepositAmount(); 
 
 if (amount != STOP)
 {
 screen.displayMessage(
 "\n请放入钱 ");
 screen.displayAmount(amount);
 //screen.displayMessageLine(" in the depositslot");
 
 bool envelopeReceived = depositSlot.isEnvelopeReceived();
 
 if (envelopeReceived)
 { 
 screen.displayMessageLine("\n收到了你的钱");
 
 
 bankDatabase.credit(getAccountNumber(), amount); 
 } 
 else 
 {
 screen.displayMessageLine("\n没有放钱"
 "交易结束");
 } 
 } 
 else //存款金额为0取消交易
 {
 screen.displayMessageLine("\n交易结束...");
 } 
} 

double Deposit::getDepositAmount() const
{
 Screen &screen = getScreen(); 
 
 screen.displayMessage("\n请输入你的存款金额 "
 "以分为单位(输入0停止): ");
 int input = keypad.receiveinput (); 
 
 
 if (input == STOP) 
 return STOP;
 else
 {
 return static_cast< double >(input) / 100; 
 } 
} 