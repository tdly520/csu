#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
    int a; 
    while(scanf("%d",&a)!= EOF )
    {int b[5]={0};
	long long c=0,d=0;
    	if(a==3)  printf("3\n");
    	else{
    		for(int i=1;i<=a;i++)
    		{
    			if(i%3==1)  {b[1]++;
				}
				else if(i%3==2) {b[2]++;
				} 
				 else {b[3]++;
				 }
				 
			}
			cout<<b[3]<<" "<<b[2]<<" "<<b[1]<<" ";
			c=(b[3]*b[1]*b[2])%1000000007;
			d=(b[3]/6*(b[3]-1)*(b[3]-2))%1000000007;
			cout<<c<<"  "<<d;
			printf("%ld\n",c+d);
		}
		
				 }
	         	
	return 0;
}
