#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
    int n;
    while (scanf("%d", &n) != EOF)
    {  
       bool zf=1;
       int sum=0,q;
       if(n==0)  break;
       while(n>0)
       {
          q=n%16;
		  n/=16;
		  if(q<10)  sum+=q;	
	   }
	   printf("%d\n",sum);




    }



    return 0;
}
