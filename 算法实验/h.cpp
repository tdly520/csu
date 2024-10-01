#include <stdio.h>

int a[1000],b[1000];

int main()
{
    int n,l,r;
    while (scanf("%d%d%d", &n, &l,&r) != EOF)
    {    
        bool flag=0;
        for(int i=1;i<=n;i++)
        {
        	scanf("%d%d", &a[i], &b[i]);
        	
		}
		for(int i=1;i<=n;i++)
        {
        	if(a[i]<=l &&b[i]>=r){flag=1;
        	break;
        		
			}        	
		}
		if(flag){
			printf("1\n");
			
		}
		else{
			printf("-1\n");
		}
        
        
        
        
    }

    return 0;
}

