#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
 char ch;
 int a[10000];
 char s[100000];
 int i=1,num=0,j=0,t;
    gets(s);
    int len=strlen(s);
    s[len]='5';
    while(s[j]=='5'){
    		j++;	
			} 
    		
    while(j<=len)
    {ch=s[j];
    	if(ch=='5')
    	{
    		while(s[j]=='5'){
    		j++;	
			} 
    		j-=1;
    		
    		a[i]=num;
    		i++;
			

    		num=0;
    		
    		
		}
		else{
			num=num*10+int(ch-'0');
			
		}
		j++;
	}
for(int m=1;m<=i-2;m++)
    {              
        
        for(j=1;j<i-m;j++)
        {
            if(a[j]>a[j+1])
            {
                t=a[j];
                a[j]=a[j+1];
                a[j+1]=t;
            }
        }

}
for(int m=1;m<=i-1;m++)
{
	cout<<a[m]<<" ";
}
     
	

	return 0;
}
