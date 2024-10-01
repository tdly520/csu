#include<bits/stdc++.h>
#include<string>
using namespace std;
bool j(int x)
{
	if(x%2==1)  return 1;
	else return 0;
}
int main()
{
   int n;
    while(scanf("%d",&n)!= EOF )
    {   int a[n+1];
	for(int i=1;i<=n;i++)
	{
		scanf("%d",&a[i]);
	 } 
	if(j(n)==0)  
	{
		printf("No\n");
	   } 
	 else   {
	 	if(j(a[1])&&j(a[n]))  printf("Yes\n");	 
	 	else printf("No\n");
		 }
	}
     
	

	return 0;
}
