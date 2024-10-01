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
  cout<<"账户余额："<<cashmoney<<endl;

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
    cout<<"糖果机还剩："<<stock<<endl;
   }
   
   else 
   {
    cout<<"卖完啦"<<endl;}
}


void showmenu()
{
  cout<<"欢迎来到糖果机"<<endl;
  cout<<"1--a   "<<"2--b"<<endl;
  cout<<"3--c   "<<"0--退出"<<endl;
}

int mian()
{
  cash ckk(50);
  candy a(1,10);
  candy b(2,10);
  candy c(3,10);

showmenu();
  
int k;
  cout<<"想要的糖果库存的序号"<<endl;
  cin>>k;
  while(k!=0)
  {
    switch(k)
  {
    case(1):cout<<"购买了a"<<endl;
    a.buy();
    ckk.showbalance(1);
    break;
    case(2):cout<<"购买了b"<<endl;
    b.buy();
    ckk.showbalance(2);
    break;
    case(3):cout<<"购买了c"<<endl;
    c.buy();
    ckk.showbalance(3);
    break;
    case(0):break;
    default:cout<<"错误"<<endl;

  }
  showmenu();
   cout<<"想要的糖果库存的序号"<<endl;
  cin>>k;
  }
  
  
return 0;
//system("pause");
}
