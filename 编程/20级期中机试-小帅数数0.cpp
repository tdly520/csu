#include<bits/stdc++.h>
#include<string>
using namespace std;

long long jc(long  n)
{
	if(n==1)  return 1;
	else return  n*jc(n-1); 
 } 
int main()
{
   long a;
    while(scanf("%d",&a)!= EOF )
    {   
    int m=0,n=0;
   for(int i=1;i<=a;i++)
   {
   	int j=i;
   	while(j%5==0)
   	{
   		m++;
   		j/=5;
	   }
   	
   }

	
	printf("%d\n",m);
	}
     
	

	return 0;
}
