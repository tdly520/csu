#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
    int n;
    while (scanf("%d", &n) != EOF)
    {  
        int a[n+1];
        for(int i=1;i<=n;i++)
        {
        	scanf("%d",&a[i]);
        	
		}
int f;
bool q=1;

scanf("%d",&f);
int i;
 for( i=1;i<=n;i++)
        {
        	if(f==a[i])   {
        	q=0;break;
			} 
        	
		}
		if(q)  cout<<"-1"<<endl;
		else cout<<i<<endl;
		
    }
	}
