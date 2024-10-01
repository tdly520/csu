#include <stdio.h>
int arr[100][100];  //创建二维数组用来记录每个位置能达到的最大值
void getsum(int);   //个人习惯用函数来处理
int main()
{
   int n;
   while(scanf("%d",&n)!=EOF)
   {getsum(n);
   }
 
}
 
void getsum(int n)
{
   //将数塔输入数组
   for(int i=0;i<n;i++)
   {
       for(int j=0;j<=i;j++)
       {
           scanf("%d",&arr[i][j]);
       }
   }
    //开始从上往下计算每个位置能达到的最大值
   for(int i=1;i<n;i++)
   {
       arr[i][0]+=arr[i-1][0];
       for(int j=1;j<i;j++)
       {
           arr[i][j]+=(arr[i-1][j]>arr[i-1][j-1]?arr[i-1][j]:arr[i-1][j-1]);
       }
       arr[i][i]+=arr[i-1][i-1];
   }
   //检测最底层每个位置能够到达的最大值，来得到整个塔能得到的最大值
   int sum=arr[n-1][0];
 
   for(int i=1;i<n;i++)
   {
       sum=arr[n-1][i]>sum?arr[n-1][i]:sum;
   }
 
   //将结果输出
   printf("%d\n",sum);
}
