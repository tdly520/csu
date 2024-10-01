#include<bits/stdc++.h>
#include<string>
using namespace std;
int e(int m,int n)
{   int temp;
	if(m<n) 
    {
        temp = m;
        m = n;
        n = temp;
    }
    int i=m;
    while(1)
    {
    	if(i%m==0 && i%n==0)
        { 
		return i;
            
        }
        i++;
	}
        
    
}
int r(int q,int w)
{   int sum=0;
    bool s=0;
	for(int j=1;j<=12;j++)
	{
		if(q*w%j==0&&(q*w/j)<=31&&w%j==0&&w%(q*w/j)==0&&e(j,(q*w/j))==w) {
		if(s) {return 13;}
		sum=j;	
		s=1;	
		
		}
	}
	return sum;
}
int main()
{
   int n;
    while(scanf("%d",&n)!= EOF )
    {  
        int x[n+1],y[n+1],z[n+1];
        for(int i=1;i<=n;i++)
        {
        	scanf("%d%d%d",&x[i],&y[i],&z[i]);
		}
		for(int i=1;i<=n;i++)
		{   int w=0;
			w=r(x[i],y[i]);
			if(w==0) printf("Case #%d: -1\n",i);
			else if(w==13) printf("Case #%d: 1\n",i);
			else printf("Case #%d: %d/%.2d/%.2d\n",i,z[i],w,x[i]*y[i]/w);
		}
	}
     
	

	return 0;
}
