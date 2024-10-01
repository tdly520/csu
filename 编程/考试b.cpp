#include<stdio.h>
#include<string.h>
int main(void)
{
  int n;
    while (scanf("%d",&n) != EOF)
    {  
     int q=0,w=0;
     int a[n+1];
	 int j[n+1]={};
	 int o[n+1]={};
     for(int i=1;i<=n;i++)
     {
     	scanf("%d",&a[i]);
     	if(a[i]%2==1)  {q++;
     		j[q]=a[i];
     		
		 }
		 else{w++;
		 	o[w]=a[i];
		 	
		 }
	 }
	 for(int i=1;i<q;i++){
		for(int z=1;z<q;z++){
			if(j[z]>j[z+1]){
				int t=j[z];
				j[z]=j[z+1];
				j[z+1]=t;
	 
		}
		}
	}
	 for(int i=1;i<w;i++){
		for(int z=1;z<w;z++){
			if(o[z]>o[z+1]){
				int t=o[z];
				o[z]=o[z+1];
				o[z+1]=t;
	 
		}
		}
	}
	for(int i=1;i<=q;i++)
	{
		printf("%d ",j[i]);
	}
	printf("\n");
	
for(int i=1;i<=w;i++)
{
	printf("%d ",o[i]);
}
printf("\n");
    }
    return 0;
}
