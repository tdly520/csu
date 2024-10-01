#include<bits/stdc++.h>
using namespace std;
int main()
{   

	
    int a,b,c;
    int max=0;
while(cin>>a)
{
   cin>>b>>c;
   max=a;
   if(max<b) max=b;
   if(max<c) max=c;
   if(max<a+b&&max<b+c&&max<a+c)   cout<<"yes"<<endl;
   else cout<<"no"<<endl;
}
    
	return 0;
}
