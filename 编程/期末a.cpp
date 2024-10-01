#include<stdio.h>
int main()
{
	int a[5];   
    
    while (scanf("%d.%d.%d.%d",&a[1],&a[2],&a[3],&a[4]) != EOF)
    { 
    _Bool f=0;
    for(int i=1;i<=4;i++)
    {
    	if(a[i]<=255&&a[i]>=0)  f=0;
    	else {
    		f=1;break;
		}
	}
	if(f)  printf("No\n");
	else printf("Yes\n");
     
    	
    	
    	
    	
    	
    	
    	
	}
    
    
    
    
    
    
}
