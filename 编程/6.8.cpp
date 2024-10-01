#include<bits/stdc++.h>
using namespace std;
int main()
{   
    int a,b,c;
	printf("Enter number of days in month: ");
	scanf("%d",&a);
	printf("Enter starting day of the week (1=Sun,7=Sat): ");
	scanf("%d",&b);
	for(int i=1;i<=b;i++)
	{
		printf("\t");
	};
	for(int i=1;i<=a;i++)
	{
		
	    printf("\t%d",i);
	      
		if((i+b)%7==0)  printf("\n");
		
	}
	return 0;
}
