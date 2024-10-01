#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
   int n;
   char z[33]="1abcdefghijklmnopqrstuvwxyz";
    while(scanf("%d",&n)!= EOF )
    {  int a[n+1];
    for(int i=1;i<=n;i++)
     {
     	scanf("%d",&a[i]);
	 }
	for(int i=1;i<=n;i++)
	{
		for(int j=1;j<=a[i];j++)
		{
			for(int m=1;m<=a[i]-j;m++) printf(" ");
			for(int m=1;m<=j;m++)  printf("%c",z[m]);
			for(int m=j-1;m>=1;m--) printf("%c",z[m]); 
			printf("\n");
		}
		for(int j=1;j<=a[i]-1;j++)
		{
			for(int m=1;m<=j-1;m++) printf(" ");
			printf("a");
			for(int m=1;m<=2*a[i]-1-2*j;m++) printf(" ");
			printf("a");
			printf("\n");
		}
		for(int m=1;m<=a[i]-1;m++) printf(" ");
		printf("a\n");
	}


}
	return 0;
}
