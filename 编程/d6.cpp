#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
   

	int n,a[100009]={0};
	cin >> n;
	for(int i=0;i<n;i++)
	{
		int x;
		cin >> x;
		a[x]++;                   
	} 
	int max=0,maxi=0;            //max重数   maxi众数 
	for(int i=0;i<100009;i++)
	{
		if(a[i]>max)
		{
			max=a[i];
			maxi=i;
		}
		else if(a[i]==max){if(i<maxi)  max=a[i];
			maxi=i;
		}	
	} 
	cout << maxi << endl;
	cout << max;
 
	
     
	

	return 0;
}
