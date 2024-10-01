#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
	string str;
	int len,i;
	while(cin>>str)
	{
			len=str.length();
	if(len==1&&str=="0")  cout<<"0";
	if(str[0]=='-')
	{
		cout<<"-";
		int j=len-1;
		while(str[j]=='0'&&j>=1)  j--;
		for(i=j;i>=1;i--)cout<<str[i];
	}
	else{

			int j=len-1;
		while(str[j]=='0'&&j>=1)  j--;
		for(i=j;i>=0;i--)cout<<str[i];
		}
		cout<<endl;
	}

	return 0;
}

