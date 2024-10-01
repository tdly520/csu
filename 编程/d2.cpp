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
   cout<<max<<endl;
}
    
	return 0;
}
