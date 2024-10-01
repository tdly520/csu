#include<stdio.h>
#include<string>
#include <string.h>
int main()
{
    int a;
    while(scanf("%d",&a)!= EOF )
    { 
      char b[a+1][20];
      int max=1,c[a+1],ans;
      
      for(int i=1;i<=a;i++)
      {
      	scanf("%s",b[i]);
      	//printf("%s\n",b[i]);
      	bool z=1;
      	for(int j=1;j<=i-1;j++)
      	{
      		if(strcmp(b[i], b[j]) == 0) {c[j]+=1;z=0;break;
			  } 
      	
		  }	if(z==1) {c[i]=1;
		  }
	}	  
		  
	  
	  for(int i=1;i<=a;i++)
	  {
	  	if(c[i]>max) {max=c[i]; ans=i;
		  }
		  printf("%d",c[i]);
	  }
	  
       printf("%s\n",b[ans]);	  
    
	}

	return 0;
}
