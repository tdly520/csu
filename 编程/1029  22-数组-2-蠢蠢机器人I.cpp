#include<stdio.h>
int main()
{
	int m,n;
	
	scanf("%d",&m);
	for(int q=1;q<=m;q++)
	{
		scanf("%d",&n);
		char str[1000];
		int a[1000],z;
		for(int i=1;i<=n;i++)
		{
			scanf("%s",str);
			
			if(str[0]=='L') a[i]=1;
			else if(str[0]=='R') a[i]=0;
			else scanf("%s %d",str,&z),a[i]=a[z];
			
		}
		int sum=0;
		for(int i=1;i<=n;i++)
		{
			if(a[i]==1) sum--;
			else sum++;
			
		}
		printf("%d\n",sum );
		
		
		
		
	 } 
	
}
