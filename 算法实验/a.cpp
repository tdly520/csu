#include<bits/stdc++.h>
using namespace std;
int trans(int a)         //��ÿ��Ѫ��ת������������ӵ���
{
    if(a%2==0) return a/2;
    else
    {
        return a/2+1;
    }
}
int n;
int a[10005];
int main()
{
    while(scanf("%d",&n)!=EOF)
    {
    for(int i=1;i<=n;i++)
    {
        int b;
        scanf("%d",&b);
        a[i]=trans(b);
    }
    sort(a+1,a+1+n);         //����sort�������������ӵ���������������
    int ans=0;
    ans+=a[1];               //��һ���֣�����������Ѫ������������ӵ���
    for(int i=1;i<=n;i++)
    {
        if(i==1||a[i]-a[i-1]==0||a[i]-a[i-1]==1) continue;        //�����ǰ���������ӵ����� 
        
        else ans+=a[i]-a[i-1]-1;             //��������ϣ���������ӵ�
    }
    printf("%d\n",ans);
    }
     return 0;
}
