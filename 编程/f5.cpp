/*#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
   int a;
    while(scanf("%d",&a)!= EOF)
    {   if(a==0) break; 
	int i=0;
	   while(a>1)
       { 
    	if(a%2==1)  {a=(a-1)/2;i++;
		}
    	else {a=a/2;i++;
		}
	   } 
	   printf("%d\n",i);
	}
     
	

	return 0;
}*/
#include<stdio.h>
int main()
{
int n,i,a,b;
while(scanf("%d",&n)!=EOF&&n!=0)
{
int i=0; 

                while (n > 3){
                    if (n % 3 == 0){
                        n /= 3;
                    }else {
                        n = n / 3 + 1;
                    }
                    i++;
                }
                if(n==3 or n==2) i++;
                
      printf("%d\n",i);          

}
return 0;
}


