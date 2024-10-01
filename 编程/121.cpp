#include<stdio.h>
    long long a[50][50];
int main()
{
    
    int i,j;
    long n;
    while(~scanf("%ld",&n))
    {
        for(i=0;i<n;i++)
        {
            for(j=0;j<=i;j++)
            {
                if(j==0||j==i)
                  a[i][j]=1;
                else
                  a[i][j]=a[i-1][j-1]+a[i-1][j];
            }
        }
        for(i=0;i<n;i++)
        {
            for(j=0;j<=i;j++)
              printf("%lld ",a[i][j]);
            printf("\n");
        }
            printf("\n");
    }
}
