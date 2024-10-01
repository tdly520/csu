#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
   int a;
    while(scanf("%d",&a)!= EOF )
    { 
	  char b[2*(a+1)+1][a+2];
      for(int i=1;i<=a;i++)
      {
      	for(int j=a-i;j>=0;j--)  printf(" ");
        printf("*\n");
	 }	
			
	for(int q=1;q<=a+1;q++)
	{
		printf("*")	 ;	
	}
		printf("\n");
		
	for(int i=a+2;i<=2*a+1;i++)
	{
		for(int j=2*a-i;j>=0;j--)
		{
		printf(" ");	
		}
		printf("*\n");
		}	
 
	 printf("\n");
    
	}
     
	

	return 0;
}
