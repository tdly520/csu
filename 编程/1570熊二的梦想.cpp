#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
    int a,b;
    while(scanf("%d",&a)!= EOF )
    { int i=0;
    scanf("%d",&b);
    while(a<=b)
    {
    	a*=3;
    	b*=2;
    	i++;
	}
	printf("%d\n",i);
	}

	return 0;
}
