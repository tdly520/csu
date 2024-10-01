#include<stdio.h>
#include<math.h>
#include<string.h>
char shu[27]="abcdefghijklmnopqrstuvwxyz";
 char suan (char m,char n)
{
	int i,j;
	i=m-'a';
	j=n-'a';
	i=(i+j)%26;
	return shu[i];
	
} 
int main()
{
	char a[1001],b[1001],c[1001];   
    
    while (scanf("%s %s",a,b) != EOF)
    {
    	int len1,len2;
    	len1=strlen(a);
    	
    	len2=strlen(b);
    	//printf("%d %d",len1,len2);
    	if(len1<len2) {
    		strcpy(c,b);
    		strcpy(b,a);
			strcpy(a,c); 
		} 
		len1=strlen(a);
    	
    	len2=strlen(b);
	
		for(int i=0;i<len2;i++)
		{
			a[i]=suan(a[i],b[i]);
				}    	
		for(int i=0;i<len1;i++)
		{
			printf("%c",a[i]);
				}		
				printf("\n");
    	
    	
    	
    	
    	
	}
}

    
      

