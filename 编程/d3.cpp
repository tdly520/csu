#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
    int a;
    while(scanf("%d",&a)!= EOF )
    { int b[a+1];   
    for(int i=1;i<=a;i++)
    {
    scanf("%d",&b[i]);	
	}
	for(int i=1;i<=a;i++)
	{
		for(int j=1;j<=b[i];j++)
		{ 
		   if(j<=(b[i]/2))
		       {if(j==1 )	{for(int k=1;k<=b[i]-1;k++){printf("-");}
		       printf("\n");}
		       else if(j==2 ) { for(int k=1;k<=b[i]-1;k++)
		       {
		    	if(k==1 )  printf("\\");
		    	else if(k==b[i]-1)  printf("/");
		  	   else printf(" ");		}printf("\n");
	         	}
		        else {
	          	   for(int q=1;q<=j-2;q++)
	          	   {
	          		printf(" ");
				    }
				    printf("\\");
		     	   for(int q=j;q<=b[i]-j;q++)
		     	   {
		     	   	printf("*");
					}
					printf("/\n");
					
		        
		        	
				}
			
		    }
		    else 
		    {
		       if( j==b[i])	{for(int k=1;k<=b[i]-1;k++){printf("-");}	printf("\n");}
		        /*else if( j==b[i]-1) { for(int k=1;k<=b[i]-1;k++)
		       {
		    	if(k==1 )  printf("/");
		    	else if(k==b[i])  printf("\\");
		    	else if(k==b[i]/2)  printf("*");
		  	   else printf(" ");		}printf("\n");
	         	}*/
	         	else{for(int k=1;k<=b[i]-1;k++){
	         	
				   if(k==b[i]-j) printf("/");
		     	   else if(k==(b[i]/2)) printf("*");
		     	   else if(k==j)printf("\\");
		     	   else  printf(" ");
		     	  }
					printf("\n");
					
				 
	         		
				 }
	         	
			}
		     
		
				
			
			
		}
		printf("\n");
	}
	}

	return 0;
}
