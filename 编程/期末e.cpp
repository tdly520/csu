#include<stdio.h>
#include<math.h>
#include<string.h>
int gcd( int x, int y )
{
    int temp;
    if(x > y)
    {
        temp = x;
        x = y;
        y = temp;
    }
    do
    {
        temp = x % y;
        x = y;
        y = temp;
    }while(temp != 0);
    return x;
}
int main()
{
	char str[300],x[27]="abcdefghijklmnopqrstuvwxyz",d[27]="ABCDEFGHIJKLMNOPQRSTUVWXYZ",s[10]="123456789";
    
    while (gets(str))
    {   
	    int X=0,D=0,S=0;
    	int len=strlen(str);
    	int m=1,k=len-1;
    	for(int i=len-1;i>=0;i--)
    	{
    		
    		if(str[i]==' ')  {
    			for(int j=i+1;j<=k;j++)
    			{
    				printf("%c",str[j]);
				}
				printf(" ");
				k=i-1;
    		    m++;	
			}
    		
		}
		for(int j=0;j<=k;j++)
    			{
    				printf("%c",str[j]);
				}
				printf("\n");
		int n;
		n=gcd(len,m);
		if(n==1){
			printf("*\n");
		}
		else{
			for(int i=1;i<=n-1;i++)
		{
			printf(" ");
		}
		for(int i=1;i<=n;i++)
		{
			printf("*");
		}
		printf("\n");
		for(int i=1;i<=n-2;i++)
		{
			for(int j=1;j<=n-1-i;j++)
			{
				printf(" ");
			}
			printf("*");
			for(int j=1;j<=n-2;j++)
			{
				printf("%c",d[D]);
				D++;
				D=D%26;
			}
			printf("*");
			for(int j=1;j<=i-1;j++)
			{
				printf("%c",s[S]);
				S++;
				S=S%9;
			}
			printf("*\n");
				
		}
    	for(int j=1;j<=n;j++)
    	{
    		printf("*");
		}
		for(int j=1;j<=n-2;j++)
			{
				printf("%c",s[S]);
				S++;
				S=S%9;
			}
			printf("*\n");
    	for(int i=1;i<=n-2;i++)
    	{
    		printf("*");
    		for(int j=1;j<=n-2;j++)
    		{
    			printf("%c",x[X]);
    			X++;
    			X=X%26;
			}
			printf("*");
			
			for(int j=1;j<=n-2-i;j++)
			{
			    printf("%c",s[S]);
				S++;
				S=S%9;	
			}
			printf("*\n");
		}
		for(int i=1;i<=n;i++)
		{
			printf("*");
			
		}
		printf("\n");
    	
		}
		
    	
    	
    	printf("\n");
    	
	}
}

    
      

