#include<bits/stdc++.h>
#include<string>
using namespace std;
bool haoshu(int x,int y)
{
	if((x*y)%(x+y)==0) return 1;
	else return 0;
}
int main()
{
   int n;
    while(scanf("%d",&n)!= EOF )
    { int sum=0;
      for(int i=1;i<=n-1;i++)
      {
      	for(int j=i+1;j<=n;j++)
      	{
      		if(haoshu(i,j)) sum++;
		  }
	  }
	  printf("%d\n",sum);
	}
     
	

	return 0;
}
