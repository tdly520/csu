#ifndef CASH_DISPENSER_H
#define CASH_DISPENSER_H
class CashDispenser
{
public:
 CashDispenser(); 
 
 void dispenseCash(int);// ȡ����Ƿ��ܹ��ṩ������
 
 bool isSufficientCashAvailable(int) const;
private:
 static const int INITIAL_COUNT = 1000;//��ʼ���
 int count; 
}; 
#endif 