#include<bits/stdc++.h>
using namespace std;
int main()
{
    int a;
	cin>>a;
	int b=0,c=0,d=0;
	d=a%60;
	a=a/60;
	if(a>0) c=a%60;a=a/60;
	if(a>0) b=a%60;
	cout<<b<<":"<<c<<":"<<d;
	return 0;
}
