#include<bits/stdc++.h>
#include<string>
using namespace std;
void reduce(int numerator,int denominator,
            int *reduced_numerator,
			int *reduced_denominator)
{  int yue=1,min=0;
    if(numerator<denominator)  min=numerator;
    else min=denominator;
	for(int i=2;i<=min;i++)
	{
		if(denominator%i==0&&numerator%i==0)  yue=i;
	}
	*reduced_numerator=numerator/yue;
	*reduced_denominator=denominator/yue;
}
int main()
{
   int a,b,c,d;
   char fu;
    while(scanf("%d/%d%c%d/%d",&a,&b,&fu,&c,&d)!= EOF )
    { bool f=0;
       int zi,mu;
       mu=b*d;
       if(fu=='+')  zi=d*a+b*c;
       else {
       	zi=d*a-b*c;
       	if(zi<0)  {
       		zi=-zi;f=1;
		   }
	   }
       int x,y,zen;
       reduce(zi,mu,&x,&y);
       if(x/y==0){
       	if(f) {
       		if(x==0)  printf("0\n");
       		else printf("-%d/%d\n",x,y);
		   }
		   else  
		   {
		   	if(x==0)  printf("0\n");
		   	else printf("%d/%d\n",x,y);
		   }
	   }
       else{
       	
       	if(f){zen=x/y+1;
       		x=zen*y-x;
       		if(x==0)  printf("-%d\n",zen);
       		else printf("-%d+%d/%d\n",zen,x,y);
		   }
		   else {zen=x/y;
		   x=x%y;
		   if(x==0)  printf("%d\n",zen);
		   else printf("%d+%d/%d\n",zen,x,y);
		   	
		   }
	   }
	}
     
	

	return 0;
}
