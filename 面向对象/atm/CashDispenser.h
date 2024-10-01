#ifndef CASH_DISPENSER_H
#define CASH_DISPENSER_H
class CashDispenser
{
public:
 CashDispenser(); 
 
 void dispenseCash(int);// 取款机是否能够提供所需金额
 
 bool isSufficientCashAvailable(int) const;
private:
 static const int INITIAL_COUNT = 1000;//初始金额
 int count; 
}; 
#endif 