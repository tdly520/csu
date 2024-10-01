#include<stdio.h>
#include<math.h>
#include<string.h>

int main()
{
	int n;
    
    while (scanf("%d",&n) != EOF)
    {
    	for(int i=1;i<=n+1;i++)
    	{
    		for(int j=1;j<=n+1-i;j++)
			{
				printf(" "); 
			}
			for(int j=1;j<=2*i-1;j++)
			{
				printf("*");
			}
			printf("\n");
		}
		for(int i=n+2;i<=2*n+1;i++)
		{   
		    for(int j=1;j<=n;j++)
		{printf(" ");
		}
			printf("*\n"); 
		}
    	
	}
}

    
      

