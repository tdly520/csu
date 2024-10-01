#include<bits/stdc++.h>
#include<string>
using namespace std;
bool su(int n)
{   if(n==1)  return 0;
	for(int i=2;i<=sqrt(n);i++)
	{
		if(n%i==0) return 0;
	}
	return 1;
}
int main()
{
   int a;
   int q[5002],j=1,i=1;
   while(i<=5000)
   { 
    bool z=1;
   	if(su(j)) ;
	else  {   int w=j,yu=0;
   		while(w>0)
   		{
   			yu=w%10;
   			if(su(yu)&&yu!=0) ;
   			else {
   				z=0;break;
			   }
   			w/=10;
		   }
	   }
	   if(z)  {
	   	q[i]=j;i++;
	   }
	   j++;
	   
   }

   
    while(scanf("%d",&a)!= EOF )
    {
    	cout<<q[a]<<endl;
	}
     
	

	return 0;
}
