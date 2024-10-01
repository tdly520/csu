#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
    int a[4],b[4];
    while(scanf("%d",&a[1])!= EOF )
    { 
    for(int i=2;i<=3;i++)
    {
    	scanf("%d",&a[i]);
	}
	  for(int i=1;i<=3;i++)
    {
    	scanf("%d",&b[i]);
	}
	  for(int i=1;i<=3;i++)
    {
    	b[i]=abs(a[i]-b[i]);
	}
	double r=0,v=0;
	r=sqrt(b[1]*b[1]+b[2]*b[2]+b[3]*b[3]);
	v=3.1415926535897931*4.00000*(r*r*r)/3.00000;
	printf("%.3f %.3f\n",r,v);
	}

	return 0;
}
