#include<stdio.h>

void max_min(int a[],int n,int*max,int *min);
int main(void)
{
	int b[10],i,big,small;
	for(int i=0;i<=9;i++)
	{
		scanf("%d",&b[i]);
		
	}
	max_min(b,10,&big,&small);
	printf("%d %d",big,small);
}
void max_min(int a[],int n,int *max ,int *min)
{
	int i;
	*max=*min=a[0];
	for(i=1;i<n;i++)
	{
		if(a[i]>*max)  *max=a[i];
		else if(a[i]<*min) *min=a[i];
	}
}
