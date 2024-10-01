#include<bits/stdc++.h>
using namespace std;
int main()
{   

	
    int a;
    int b[5];
while(cin>>a)
{//!cin.eof()
    
    b[1]=(a%10+9)%10;
    a/=10;
     b[2]=(a%10+9)%10;
    a/=10;
     b[3]=(a%10+9)%10;
    a/=10;
    b[4]=(a%10+9)%10;
    a=b[2]*1000+b[1]*100+b[4]*10+b[3];
    cout<<"The encrypted number is "<<a<<endl;
    
}
    
	return 0;
}
