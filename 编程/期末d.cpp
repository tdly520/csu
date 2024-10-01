#include<stdio.h>
#include<math.h>
#include<string.h>

int main()
{
	int n;
    
    while (scanf("%d",&n) != EOF)
    {
    	int a[101];
		for(int i=1;i<=n;i++)
		{
			scanf("%d",&a[i]);
		 } 
		 for(int i=0;i<n;i++)
		 {
		    for(int j=0;j<n;j++){
			if(a[j]>a[j+1]){
				int t=a[j];
				a[j]=a[j+1];
				a[j+1]=t;
			}
		    }
	     }
	     int  sum=a[1];
	     _Bool f=0;
	     for(int i=2;i<=n;i++)
	     {
	     	
	     	if(a[i]>sum) ;
	     	else {f=1;
	     	break;
	     		
			 }
		    sum+=a[i];
		
		 }
		 if(f)  printf("No\n");
		 else printf("Yes\n");
	     
	
    	
	}
}

    
      

