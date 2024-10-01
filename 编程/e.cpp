#include<bits/stdc++.h>
using namespace std;
int main()
{   

	
    int a;
    
cin>>a;
int b[a*2+1];
for(int i=1;i<=a*2;i+=2)
{
	cin>>b[i]>>b[i+1];
	
}
for(int i=1;i<=a*2;i+=2)
{
	cout<<b[i]+b[i+1]<<endl;
}

	return 0;
}
