#include "CashDispenser.h" 
CashDispenser::CashDispenser()
{
 count = INITIAL_COUNT; 
} 
void CashDispenser::dispenseCash(int amount)
{
 int billsRequired = amount / 20; 
 count -= billsRequired; 
} 
bool CashDispenser::isSufficientCashAvailable(int amount) const//ȡ����Ƿ����㹻���ֽ���ɹ���ȡ
{
 int billsRequired = amount / 20; 
 if (count >= billsRequired)
 {
  return true; 
 }
 
 else{
  return false; 
 }
 
} 