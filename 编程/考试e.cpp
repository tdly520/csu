#include<stdio.h>
#include<string.h>
#include<math.h>

int main()
{
    char str[31];
    
    while (scanf("%s",str) != EOF)
    {  
    int n;
	n=strlen(str);
	//printf("%d",n);
    int a[31];
    for(int i=0;i<n;i++)
    {
    	a[i]=str[i]-'a'+1;
    	//printf("%d ",a[i]);
	}
	unsigned long q=0;
	bool fu=0;
	for(int i=1;i<=n;i++)
	{
		
		if(q+pow(-1,i)*a[i-1]*pow(10,i-1)<0)
		{
			q=-q-pow(-1,i)*a[i-1]*pow(10,i-1);
			fu=1;
			
		}
		else{
			q+=pow(-1,i)*a[i-1]*pow(10,i-1);
			fu=0;
		}
	}
	
	
	if(fu){
		
		printf("-0.");
	}
	else printf("0.");
	unsigned long z[31],x;
	x=q;
	for(int i=1;i<=n;i++)
	{
		z[i]=x%10;
		x/=10;
		
		//printf("%d",z[i]);
	}
	int w=1;
	while(z[w]==0)
	{
		w++;
	}
	for(int i=n;i>=w;i--)
	{
		printf("%d",z[i]);
	}
	printf("\n");
	//printf("%.nlf\n",q);

    }
}

