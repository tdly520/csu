#include<bits/stdc++.h>
#include<string>
using namespace std;
bool su(int q)
{   if(q==1 ) return 0;
    
	for(int i=2;i<=sqrt(q);i++)
	{
		if(q%i==0)   return 0;
	}
	return 1;
}
bool hu(int q)
{
	int w=q,z=0;
	while(w>0)
	{
		z=z*10+(w%10);
		w/=10;
	}
	if(z==q)  return 1;
	else return 0;
}
int main()
{
   int a,b;
    while(scanf("%d %d",&a,&b)!= EOF )
    { int sum=0;
      for(int i=a;i<=b;i++)
      {
      	if(su(i)&&hu(i)) sum++;
	  }
      cout<<sum<<endl;
      
	}
     
	

	return 0;
}
