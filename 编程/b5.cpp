#include<stdio.h>
#include<string>


int main()
{
   int a,b,c,d,e;
    while(scanf("%d:%d,%d/%d/%d",&a,&b,&c,&d,&e)!= EOF )
    {    
    	if(a>=12) {a=a%12;  printf("%d%02d%02d,%02d:%02dPM\n",e,c,d,a,b);
		} 
		
		else printf("%d%02d%02d,%02d:%02dAM\n",e,c,d,a,b);
    	
    
    
    	
	}
     
	

	return 0;
}
