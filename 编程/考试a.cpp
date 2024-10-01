#include<stdio.h>



int main()
{
    int h,m,s,n;   
    char fu;
    while (scanf("%d:%d:%d%c%d",&h,&m,&s,&fu,&n) != EOF)
    {  
     
      	m=(n+s)/60+m;
	  s=(n+s)%60;	
	  
	  if(m>=60){
	  	h=m/60+h;
	  	m=m%60;
	  }
	  h=h%24;
	  printf("%02d:%02d:%02d\n",h,m,s);



    }
}
