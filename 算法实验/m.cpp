#include<stdio.h>
#include<math.h>
int main()
{
	int n;
	while(scanf("%d",&n)!=EOF)
	{
		
	
	
	int count=0; 
	getchar();
	char c;
	scanf("%c",&c);
	int h=sqrt((n+1)/2);
	for(int i=h;i>=1;i--)
    {
        for(int j=1;j<=h-i;j++)
        {
        	printf(" ");
		}
		for(int j=1;j<=2*i-1;j++)
		{
			printf("%c",c);count++;
		}
		printf("\n");
	}
	for(int i=2;i<=h;i++)
    {
        for(int j=1;j<=h-i;j++)
        {
        	printf(" ");	
		}
		for(int j=1;j<=2*i-1;j++)
		{
			printf("%c",c);
			count ++;
		}
		printf("\n");
	}
	printf("%d\n",n-count);}
}

