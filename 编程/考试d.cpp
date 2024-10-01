#include<stdio.h>
#include<string.h>
#include<math.h>
int c[1002]={};
int a[1002]={};
int b[1002]={};
int ce(int ) ;
int n,m;
int main()
{
      
    
    while (scanf("%d",&n) != EOF)
    {  
    
    for(int i=1;i<=n;i++)
    {
    	scanf("%d",&a[i]);
	}
	
	
	scanf("%d",&m);
	 for(int i=1;i<=m;i++)
    {
    	scanf("%ld",&b[i]);
	}
	
	c[0]=0;
	for(int i=1;i<=n;i++)
	{
		c[i]=c[i-1]+a[i];
	}
	for(int i=1;i<=m;i++)
	{
		b[i]=ce(b[i]);
		printf("%d\n",b[i]);
	}

    }
}
int ce(int q)
{   int j=n;
	while(c[j]>=q)
	{
		j--;
	}
	return j+1;
}
