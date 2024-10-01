#include<stdio.h>
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
	  int sum=0;
	  for(int i=1;i<=n;i++)
	  {
	  	if(sum<10)  sum+=a[i];
	  	else if(sum>=10&&sum<15)  sum+=a[i]*0.8;
	  	else if(sum>=15&&sum<40)  sum+=a[i]*0.5; 
		  else sum+=a[i]; 
	  }
	  if(n==31 ) printf("Yes\n");
	  else{if(sum>=100)  printf("Yes\n");
	  else printf("No\n");
	  }
	  

    }
}
