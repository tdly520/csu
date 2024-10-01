#include<bits/stdc++.h>
#include<string>
using namespace std;
bool run(int x)
{
	if(x%400==0||(x%4==0&&x%100!=0))  return 1;
	else return 0;
}
int main()
{
    
	int n;
   
    while(scanf("%d",&n)!= EOF )
    {  int a[n+1],b[n+1],c[n+1];
    for(int i=1;i<=n;i++)
     {
     	scanf("%d-%d-%d",&a[i],&b[i],&c[i]);
	 }
	 for(int i=1;i<=n;i++)
	 {
	 	int sum=0;
	 	int yue=b[i];
	 		if(yue==4 or yue==6 or yue==9 or yue==11)
          	{
          		sum=30-c[i];
			  }
			else if(yue==2)  {
			  	        if(run(a[i]))  {
          		                  sum=(29-c[i]);}
				        else     {
          		               sum=(28-c[i]);}
				                   
			  }
			  else{
			  	
          		sum=(31-c[i]);
			  }
			  yue++;
	 	while(yue<=12)
          {
          	if(yue==4 or yue==6 or yue==9 or yue==11)
          	{
          		sum=(sum+30);
			  }
			else if(yue==2)  {
			  	        if(run(a[i]))  {
          		                  sum=(sum+29);}
				        else     {
          		               sum=(sum+28);}
				                   
			  }
			  else{
			  	
          		sum=(sum+31);
			  }
			  yue++;
		  }
		  int nian=a[i]+1;
	 	while(nian<2021)
	 	{
	 		if(run(nian))  sum+=366;
	 		else sum+=365;
	 		nian++;
		 }
		 sum+=2;
		 if(a[i]==2021)  sum=1;
		 printf("%d\n",sum);
	 }
	 
	 
	 
	 
     }
	

	return 0;
}
