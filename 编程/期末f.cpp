#include<stdio.h>
#include<math.h>
#include<string.h>

int main()
{
	int n;
    
    while (scanf("%d",&n) != EOF)
    {   char q[15][10]={};
    int a[15]={},b[15]={},sum=0;
        char ch;
		int e=0,m,z,x,y;
        for(int i=1;i<=n*(n-1)/2;i++)
        {   char str1[10]={},str2[10]={};
		    
		    e=0;
		    while((ch = getchar()) !=':')
            {if(ch!='\n'){
            	str1[e]=ch;
			  e++;
			}
			  
			}

    	    scanf("%s %d:%d",str2,&m,&z);
    	    //printf("%d",m);
    	    x=0;
    	    y=0;
    	    for(int j=1;j<=sum;j++)
    	    {
    	    	if(strcmp(q[j],str1)==0) {
    	    		x=j;
    	    		
				}
				if(strcmp(q[j],str2)==0){
					y=j;
				}
			}
			if(x==0) {
				sum++;
				//printf("%d",sum);
				strcpy(q[sum],str1);
				x=sum;
				
			}
				if(y==0) {
				sum++;
				strcpy(q[sum],str2);
				y=sum;
			}
			if(m>z){
				a[x]+=3;
				b[x]+=m-z;
				
			}
			else if(m==z){
				a[x]+=1;
				a[y]+=1;
			}
			else{
				a[y]+=3;
				b[y]+=z-m;
			}
	  	//printf("%d\n",sum);
			}
			
			for(int i=1;i<n;i++)
	 		{
	         	for(int j=1;j<n;j++)
				{
		    	    if(a[j]<a[j+1]){
				     int t=a[j];
				    a[j]=a[j+1];
			       	a[j+1]=t;
			       	char str[10];
			       	strcpy(str,q[j]);
			       	strcpy(q[j],q[j+1]);
			       	strcpy(q[j+1],str);
		        	}
		        	else if(a[j]==a[j+1])
		        	{
		        	if(b[j]<b[j+1])
					{
						int t=a[j];
				    a[j]=a[j+1];
			       	a[j+1]=t;
			       	 t=b[j];
				    b[j]=b[j+1];
			       	b[j+1]=t;
			       	char str[10];
			       	strcpy(str,q[j]);
			       	strcpy(q[j],q[j+1]);
			       	strcpy(q[j+1],str);
						}
						else if(b[j]==b[j+1])
						{
							if(q[j][15]<q[j+1][15])
							{
								int t=a[j];
				    a[j]=a[j+1];
			       	a[j+1]=t;
			       	 t=b[j];
				    b[j]=b[j+1];
			       	b[j+1]=t;
			       	char str[10];
			        strcpy(str,q[j]);
			       	strcpy(q[j],q[j+1]);
			       	strcpy(q[j+1],str);
							}
							}	
					}
		        	
	           	}
        	}   
			
			for(int i=1;i<=n;i++)
			{
				printf("%s ",q[i]);
			}
			printf("\n");
	}
	
    	
}
/*
3
Aa:Bbb 2:1
Bbb:Ee 3:1
Ee:Aa 1:1 
4
AAA:BBB 3:1
AAA:CCC 2:1
BBB:CCC 5:0
AAA:DDD 2:0
DDD:BBB 1:1
DDD:CCC 1:3*/
      

