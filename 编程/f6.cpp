#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
    int n;
    while (scanf("%d", &n) != EOF)
    {  
        char ch;
       
        int l=0,r=0;
        for(int i=0;i<=n;i++)
        {
        	ch=getchar();
        	if(ch=='L')  l++;
        	if(ch=='R')   r++;		}
        
        	//cout<<l<<r;
			int left;
			if(l>=r){left=l-r;if(left%4==0)  printf("N\n");
        	else if(abs(left%4)==1)  printf("W\n");
        	else if(left%4==2)  printf("S\n");
        	else printf("E\n");
			}
        	else {left=r-l;if(left%4==0)  printf("N\n");
        	else if(abs(left%4)==1)  printf("E\n");
        	else if(left%4==2)  printf("S\n");
        	else printf("W\n");
			}
        	
		
    }
}
