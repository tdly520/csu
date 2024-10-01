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
bool CashDispenser::isSufficientCashAvailable(int amount) const//取款机是否有足够的现金金额可供提取
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