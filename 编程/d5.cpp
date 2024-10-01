#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
    int n;
    while(scanf("%d",&n)!= EOF)
    { 
	if(n==0)  break;
	double z=0;
    int q=n/8;
    
    if(q>=1){if(n%8>=6) {printf("%d\n",q*18+10+(n%8-4)*2);
	}   
       else {z=q*18+2.4*(n%8);
       if((int(z))==z) printf("%.0f\n",z);
	     else   printf("%.1f\n",z);
	   }
       
	}
	else {
 		if(n%8<=4)   {printf("%d\n",10);
		 }
 		else  {printf("%d\n",10+(n%8-4)*2);
		 }
		 
	}
      
    }	 

     return 0;
}



