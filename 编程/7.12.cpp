#include<bits/stdc++.h>
using namespace std;
int main()
{  double a,b=0;  
 char ch;
    printf("Enter an expression: ");
  scanf("%lf",&a);
   
    while((ch=getchar())!='\n')
    {
    	scanf("%lf",&b);
    	
    	
		 switch(ch)
           {
           case '+' :
           a=a+b;break;
          case '-' :
          a=a-b;break;
          case '*' :
          a=a*b;break;
           case '/' :
           a=a/b;break;
           }
          
          
	}	
	printf("Value of expression: %f",a);
	return 0;
}
