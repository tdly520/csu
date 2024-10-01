#include<bits/stdc++.h>
#include<string>
using namespace std;
int check(int i,int x){
	int a[10]={0};
	int j=0;
	int flag=1;
	while(i){
		a[i%10]++;
		i=i/10;
	}
	if(x<10000)
		a[0]++;
	while(x){
		a[x%10]++;
		x=x/10;
	}
	for(j=0;j<10;j++){
		if(a[j]!=1){
			flag=0;	
		}
	}
	return flag;
}
int main()
{
    int n;
    int q=0;
    while (scanf("%d", &n),n!=0)
    {  if(q)
		cout<<endl;
		q++;	
	  
       
		int x;
		int count=0;
		for(int i=12345;i<=98765;i++)
		{
			if(i%n==0){
				x=i/n;
				if(check(i,x)==1)
				{
					if(x>10000)
						printf("%d / %d = %d\n",i,x,n);	
					else 
						printf("%d / 0%d = %d\n",i,x,n);	
					count++;
				}	
			}
		}
		if(count==0)
			printf("There are no solutions for %d.\n",n);
		
	} 
	return 0;	
} 




