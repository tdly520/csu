#include<iostream>

using namespace std;
class cash
{
  public:
cash();
cash(int cashmoney);
void showbalance(int balance);

private:
int cashmoney;

};


class candy
{   


     public:
    
    candy();
    candy(int p,int s);
   void buy();

    private:
   int  price;
    int stock;
   
    
 
   
    
    
};

cash::cash()
{
  cashmoney=50;
}
cash::cash(int money)
{
  if(money>0)
  {
    cashmoney=money;
  }
  else {cashmoney=100;}
}
void cash::showbalance(int balance)
{
  cashmoney=cashmoney+balance;
  cout<<"�˻���"<<cashmoney<<endl;

}
candy::candy()
{
  stock=10;
  price=1;
}
candy::candy(int p,int s)
{
  price=p;
  stock=s;
}
void candy::buy()
{
   stock--;
   if(stock>0)
   {
    cout<<"�ǹ�����ʣ��"<<stock<<endl;
   }
   
   else 
   {
    cout<<"������"<<endl;}
}


void showmenu()
{
  cout<<"��ӭ�����ǹ���"<<endl;
  cout<<"1--a   "<<"2--b"<<endl;
  cout<<"3--c   "<<"0--�˳�"<<endl;
}

int mian()
{
  cash ckk(50);
  candy a(1,10);
  candy b(2,10);
  candy c(3,10);

showmenu();
  
int k;
  cout<<"��Ҫ���ǹ��������"<<endl;
  cin>>k;
  while(k!=0)
  {
    switch(k)
  {
    case(1):cout<<"������a"<<endl;
    a.buy();
    ckk.showbalance(1);
    break;
    case(2):cout<<"������b"<<endl;
    b.buy();
    ckk.showbalance(2);
    break;
    case(3):cout<<"������c"<<endl;
    c.buy();
    ckk.showbalance(3);
    break;
    case(0):break;
    default:cout<<"����"<<endl;

  }
  showmenu();
   cout<<"��Ҫ���ǹ��������"<<endl;
  cin>>k;
  }
  
  
return 0;
//system("pause");
}
