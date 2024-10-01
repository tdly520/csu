#include<bits/stdc++.h>
using namespace std;

bool hui(int d)
{
	int n=d;
    int y=0;
	while(d!=0)
	{
	y=y*10+d%10;
	d=d/10;
	}
	if(y==n) return 1;
	else return 0;
	
}
  
bool zhi(int v)
     {

	 for(int j=2;j<= int(sqrt(v));j++)
     {
     	if(v% j==0) return 0;
	 }
	return 1;
	 }
	 
	 int main()
{
     int a,b,j=1;
     cin >>a >>b;
     if(b>=9999999) b=9999999;
     int c[b-a];
     for(int i=a;i<=b;i++)
     {
       if(hui(i)&&i%2!=0)  {c[j]=i;j=j+1;
	   }
	   }
	   
	
	
	   for(int m=1;m<=j-1;m++)  
	   {
	   if(zhi(c[m])) cout<<c[m]<<endl;
	   }
	return 0;
	
}
