#include<stdio.h>
int main()
{
	int m,n;
	
	while (scanf("%d %d",&m,&n) !=EOF)
	{
		unsigned long a=0,b=0;
		for(int i=m;i<=n;i++)
		{
			if(i%2==1) a+=i*i;
			else b+=i*i*i;
		}
		printf("%lld %lld\n",a,b);
	
		
		
	}
}
