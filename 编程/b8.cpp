#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
   char a[82];
   gets(a);
    
    int len=strlen(a);
    
    char b[len+1];
    for(int i=0;i<len;i++)
    {int cha;
    	if(a[i]>='a'&&a[i]<='z')  {
    		cha=int (a[i]-'a');
    		b[i]='z'-cha;
		}
		else if(a[i]>='A'&&a[i]<='Z')
		{
			cha=int (a[i]-'A');
    		b[i]='Z'-cha;
		}
		else b[i]=a[i];
	}
	for(int i=0;i<len;i++)
	{
		printf("%c",b[i]);
	}
	
	
     
	

	return 0;
}
