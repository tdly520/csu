#include<bits/stdc++.h>
using namespace std;
int trans(int a)         //对每个血量转换成其所需的子弹数
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
    sort(a+1,a+1+n);         //调用sort函数，对所需子弹数进行升序排序
    int ans=0;
    ans+=a[1];               //第一部分，即打死最少血量敌人所需的子弹数
    for(int i=1;i<=n;i++)
    {
        if(i==1||a[i]-a[i-1]==0||a[i]-a[i-1]==1) continue;        //如果当前敌人所需子弹数比 
        
        else ans+=a[i]-a[i-1]-1;             //如果数组间断，则需另加子弹
    }
    printf("%d\n",ans);
    }
     return 0;
}
