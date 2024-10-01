#include<bits/stdc++.h>
using namespace std;
int main()
{   

	
    int a;
    
while(cin>>a)
{
    if(a>=91) cout<<"A"<<endl;
    else if(a>=81&&a<=90)  cout<<"B"<<endl;
    else if(a>=71&&a<=80)  cout<<"C"<<endl;
    else if(a>=60&&a<=70)  cout<<"D"<<endl;
    else if(a<=59)  cout<<"F"<<endl;
}
    
	return 0;
}
