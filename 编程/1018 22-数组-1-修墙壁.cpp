#include<stdio.h>
int main()
{
	int m,n;
	
	while (scanf("%d",&m) !=EOF)
	{
		if(m==0) break;
		else scanf("%d",&n);
		//scanf("",);
		int a[1001];
		for(int i=1;i<=n;i++)
		{
			scanf("%d",&a[i]);
		}
		for(int i=1;i<n;i++)
		{
		    for(int j=1;j<n;j++)
			{
			if(a[j]<a[j+1]){
				int t=a[j];
				a[j]=a[j+1];
				a[j+1]=t;
			     }
		    }
	    }
	    int sum=0,i=0;
	    while(sum<m)
	    {i++;
		if(i>n) break;
	    	sum+=a[i];
	    	
	    	
		}
	    if(i>n)  printf("impossible\n");
	    else printf("%d\n",i);
	
		
		
	}
}
