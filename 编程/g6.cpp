#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
    int n;
    while (scanf("%d", &n) != EOF)
    {   int a[8]={};
        int sum=0;
        for(int i=1900;i<=1900+n-1;i++)
        { bool run=0;
          if((i%4==0&&i%100!=0)	or (i%400==0))  run=1;
          int yue=1;
          while(yue<=12)
          {
          	if(yue==4 or yue==6 or yue==9 or yue==11)
          	{
          		a[(sum+13)%7]++;
          		sum=(sum+30)%7;
			  }
			else if(yue==2)  {
			  	        if(run)  {a[(sum+13)%7]++;
          		                  sum=(sum+29)%7;}
				        else     {a[(sum+13)%7]++;
          		               sum=(sum+28)%7;}
				                   
			  }
			  else{
			  	a[(sum+13)%7]++;
          		sum=(sum+31)%7;
			  }
			  yue++;
		  }
		}
        cout<<a[6]<<" "<<a[0]<<" "<<a[1]<<" "<<a[2]<<" "<<a[3]<<" "<<a[4]<<" "<<a[5]<<endl;
		
    }
}
