#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
   double  h,u,d,f;
    while(scanf("%lf%lf%lf%lf",&h,&u,&d,&f)!= EOF)
    {
    	if(h==0 && u==0 && d==0 && f==0) break;
    	  
	f=f*u;   
	h=h*100;u*=100;d*=100;
	int i=1,y=h;
	
	
	while(1)
	{   h=h-u;
	    if(h<0) {  printf("success on day %d\n",i);break;
		}
		u=u-f;
		if(u<0) u=0;
		h=h+d;
	    if(h>y){    printf("failure on day %d\n",i);break;
		}
	
	i++;
    	
    }	 
}
return 0;
}



