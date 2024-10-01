#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
   int a,j=1;
   int b[1000000];
   for( int i=6;i<=1000000;i++)
   {
    
	if(i%6==0)   {b[j]=i;j++;}
   	else{
   	int e=i%1000;
   		  while(e>0)
   	{
   		if(e%10==6)  {b[j]=i;j++;break;
		   }
   		e=e/10;
	   }
	   
	 
	   }
   	
   	
   }
  
    while(scanf("%ld",&a)!= EOF )
    {
    	printf("%ld\n",b[a]);
	}

	return 0;
}
