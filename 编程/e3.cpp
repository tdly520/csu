#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
   int a,b;
    while(scanf("%d",&a)!= EOF )
    {scanf("%d",&b);
    int c[a+1];
    for(int i=1;i<=a;i++)
    {
    	scanf("%d",&c[i]);
	}
	int max=c[1],min=c[1];
	float all=0;
	for(int i=1;i<=a;i++)
	{
		printf("%d ",c[i]);
		if(i%4==0&&i<a)  printf("\n");
		if(c[i]>max) max=c[i];
		if(c[i]<min) min=c[i];
		all+=c[i];
	}
	printf("\nmax:%d\nmin:%d\naverage:%.6lf",max,min,all/a);
	}
     
	

	return 0;
}
