#include<bits/stdc++.h>
using namespace std;
int main()
{
int a,b[10000]={0},c[200000]={0};
int all=0;
cin>>a;
 for(int i=1;i<=a;i++)
 {
 	cin>>b[i];
 	c[b[i]]=1;
	 }	
	 for(int i=2;i<=a;i++)
	 {
	 	for(int j=1;j<=i-1;j++)
	 	{
	 		if(c[b[i]+b[j]]>0){c[b[i]+b[j]]=c[b[i]+b[j]]+1;
			 }
	 		
		 }
	 }
	 
	 for(int i=3;i<=200000;i++)
	 {
	 	if(c[i]>1) all=all+1;
	 }
	 cout<<all;
	 return 0;
}
	 
	 
	

