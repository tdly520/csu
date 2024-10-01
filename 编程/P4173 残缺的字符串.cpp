#include<stdio.h>
#include<string>
#include <string.h>
int main()
{
	int m,n,c[999]={};
	scanf("%d %d",&m,&n);
	char a[m],b[n];
    scanf("%s",a);
    scanf("%s",b);
    
    int count=0;
	for(int i=0;i<=n-1;i++)
	{
		bool q=1;
	  for(int j=0;j<=m-1;j++)
	  {
	  	if(i+j+1>n)  {
	  		q=0;
	  		break;
		  }
	  	if(a[j]==b[j+i]or a[j]=='*' or b[i+j]=='*')  ;
	  	else{
	  		q=0;
	  		break;
			 
		  }
	  } 
	  if(q){
	  	for(int j=0;j<=m-1;j++)
	  	{
	  		b[i+j]=a[j];
		  }
	  	 count++;
	  c[count]=i+1;
	  }
	 
	    
	}
	//printf("%s",a);
	printf("%d\n",count);
	for(int i=1;i<=count;i++)
	{
		printf("%d ",c[i]);
	}
}
