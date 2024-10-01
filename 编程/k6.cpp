#include<bits/stdc++.h>
#include<string>
using namespace std;
int p(int a)
{
	if(a<=1)  return a;
    else if(a>1&&a%2==0)  return p(a/2)+2;
    else if(a>1&&a%3==0)  return p(a/3)+3;
    else if(a>1&&a%3!=0)  return p(a-1)+1;
	
	
	
	}
int main()
{
    int n;
    while (scanf("%d", &n) != EOF)
    {   int b[n+1];
        for(int i=1;i<=n;i++)
        {
        	cin>>b[i];
		}
		for(int i=1;i<=n;i++)
		{
		cout<<p(b[i])<<endl;	
		}



    }



    return 0;
}
