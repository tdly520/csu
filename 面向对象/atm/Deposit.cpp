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
 "\n�����Ǯ ");
 screen.displayAmount(amount);
 //screen.displayMessageLine(" in the depositslot");
 
 bool envelopeReceived = depositSlot.isEnvelopeReceived();
 
 if (envelopeReceived)
 { 
 screen.displayMessageLine("\n�յ������Ǯ");
 
 
 bankDatabase.credit(getAccountNumber(), amount); 
 } 
 else 
 {
 screen.displayMessageLine("\nû�з�Ǯ"
 "���׽���");
 } 
 } 
 else //�����Ϊ0ȡ������
 {
 screen.displayMessageLine("\n���׽���...");
 } 
} 

double Deposit::getDepositAmount() const
{
 Screen &screen = getScreen(); 
 
 screen.displayMessage("\n��������Ĵ���� "
 "�Է�Ϊ��λ(����0ֹͣ): ");
 int input = keypad.receiveinput (); 
 
 
 if (input == STOP) 
 return STOP;
 else
 {
 return static_cast< double >(input) / 100; 
 } 
} 