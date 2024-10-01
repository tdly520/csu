#include<bits/stdc++.h>
using namespace std;
int main()
{
	
	int b[2]={0,4};
	 char a[5][6]={ "12345","12345","12345","12345","12345"};
	   char  (*p)[6] = a;
	   
     if(*(*(p+b[0])+b[1])=='5') cout<<1;
     else cout<<0; 
	return 0;
}
