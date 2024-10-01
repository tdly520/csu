#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
    string ch;
     while (cin>>ch)
   {
   	long long i=0;
   	long long a=0,b=0,c=0;
   	a=count(ch.begin(),ch.end(),'C');
   	b=count(ch.begin(),ch.end(),'S');
   	c=count(ch.begin(),ch.end(),'U');
   	/*while(i<=sizeof(ch))
   	{
   	if(ch[i]=='C')  a++;
      if(ch[i]=='S')  b++;
      if(ch[i]=='U')   c++;	
	   i++;
	   }*/long long min;
	min=a; if(b<=min)  min=b;
	if(c<=min)  min=c; 

printf("%lld\n",min);
   }
   
   
   
   
    /*
	
	int a=0,b=0,c=0;
    while ((ch=getchar())!='\n')
    {  
      if(ch=='C')  a++;
      if(ch=='S')  b++;
      if(ch=='U')   c++;
    int max;
	max=a; if(b>max)  max=b;
	if(c>max)  max=c; 

printf("%d\n",max);
    }
*/


    return 0;
}
