#include <stdio.h>
int arr[100][100];  //������ά����������¼ÿ��λ���ܴﵽ�����ֵ
void getsum(int);   //����ϰ���ú���������
int main()
{
   int n;
   while(scanf("%d",&n)!=EOF)
   {getsum(n);
   }
 
}
 
void getsum(int n)
{
   //��������������
   for(int i=0;i<n;i++)
   {
       for(int j=0;j<=i;j++)
       {
           scanf("%d",&arr[i][j]);
       }
   }
    //��ʼ�������¼���ÿ��λ���ܴﵽ�����ֵ
   for(int i=1;i<n;i++)
   {
       arr[i][0]+=arr[i-1][0];
       for(int j=1;j<i;j++)
       {
           arr[i][j]+=(arr[i-1][j]>arr[i-1][j-1]?arr[i-1][j]:arr[i-1][j-1]);
       }
       arr[i][i]+=arr[i-1][i-1];
   }
   //�����ײ�ÿ��λ���ܹ���������ֵ�����õ��������ܵõ������ֵ
   int sum=arr[n-1][0];
 
   for(int i=1;i<n;i++)
   {
       sum=arr[n-1][i]>sum?arr[n-1][i]:sum;
   }
 
   //��������
   printf("%d\n",sum);
}
