#include<bits/stdc++.h>
using namespace std;
int main()
{
     
     int a,min;
     cin>>a;
     int b[a+1];
     cin>>b[1];
     min=b[1];
     for(int i=2;i<=a;i++)
     {
     	cin>>b[i];
     
     		if(b[i]<min) min=b[i];
		 
	 }
	 
	 cout<<min;
	return 0;
	
}
