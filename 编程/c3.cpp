#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
   int a,j; 
    while(scanf("%d",&a)!= EOF )
    {   int c=0,d=0; 
    for(int i=1;i<=a;i++)
    {   
	    int b[2]={0,0};
	    j=i;
    	 while(j>0)
        {
    	 b[j%2]++;
         j=j/2;
	    }
	    if(b[0]>=b[1])  d++;
	    else c++;
	}
    
	printf("%d %d\n",c,d);
	}
     
	

	return 0;
}
