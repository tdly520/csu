#include<stdio.h>
#define N 4


int fun(int x, int y);

int main()
{
    int a,b,c;
    scanf("%d %d",&a,&b);
    c=fun(a,b);
    printf("%d",c);
    return 0;
}

/********** Begin **********/
int fun(int x, int y)
{
   double i=1,q=y;
   while(y>0)
   {
   	y=y/10;
   	i*=10;
}
x=x*i+q;
return x;
}


/********** End **********/

