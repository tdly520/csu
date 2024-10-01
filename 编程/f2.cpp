#include<bits/stdc++.h>
using namespace std;
int main()
{   

	
    int a,b,c;
    int max=0;
while(cin>>a)
{
   cin>>b>>c;
   
   if((a-b)%c==0&&a>b)   cout<<"Happy!"<<endl;
   else cout<<"UnHappy!"<<endl;
}
    
	return 0;
}
