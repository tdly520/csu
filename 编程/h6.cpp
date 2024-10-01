#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
   int n;
    while(scanf("%d",&n)!= EOF )
    {
     int  a[n+1][3]={},sum[n+1]={};
     
     char b[n+1][100]={};
     for(int i=1;i<=n;i++)
     {
     	scanf("%s %d %d %d",&b[i][90],&a[i][1],&a[i][2],&a[i][3]);
     	sum[i]=a[i][1]+a[i][2]+a[i][3];
	 }
	 int max1=0,max2=0,max3=0;
	 for(int i=1;i<=n;i++)
	 {
	 	
	 	if	(sum[i]>sum[max3] or (sum[i]==sum[max3]&&b[i][90]<b[max3][90])) max3=i;
	  if(sum[i]>sum[max2] or (sum[i]==sum[max2]&&b[i][90]<b[max2][90])) {max3=max2;max2=i;}
		 
	 	 if(sum[i]>sum[max1]  or (sum[i]==sum[max1]&&b[i][90]<b[max1][90])) {max2=max1;max1=i;
		 }
		 
	 }
	
	 
	 	printf("%s %d\n",&b[max1][90],sum[max1]);
	 	printf("%s %d\n",&b[max2][90],sum[max2]);
	 	printf("%s %d\n \n",&b[max3][90],sum[max3]);
	 max1=0,max2=0,max3=0;
	 for(int i=1;i<=n;i++)
	 {
	 	
	 	if	(a[i][1]>a[max3][1] or (a[i][1]==a[max3][1]&&b[i][90]<b[max3][90])) max3=i;
	  if(a[i][1]>a[max2][1] or (a[i][1]==a[max2][1]&&b[i][90]<b[max2][90])) {max3=max2;max2=i;}
		 
	 	 if(a[i][1]>a[max1][1]  or (a[i][1]==a[max1][1]&&b[i][90]<b[max1][90])) {max2=max1;max1=i;
		 }
		 
	 }
	
	 
	 	printf("%s %d\n",&b[max1][90],a[max1][1]);
	 	printf("%s %d\n",&b[max2][90],a[max2][1]);
	 	printf("%s %d\n \n",&b[max3][90],a[max3][1]);
	max1=0,max2=0,max3=0;
	 for(int i=1;i<=n;i++)
	 {
	 	
	 	if	(a[i][2]>a[max3][2] or (a[i][2]==a[max3][2]&&b[i][90]<b[max3][90])) max3=i;
	  if(a[i][2]>a[max2][2] or (a[i][2]==a[max2][2]&&b[i][90]<b[max2][90])) {max3=max2;max2=i;}
		 
	 	 if(a[i][2]>a[max1][2]  or (a[i][2]==a[max1][2]&&b[i][90]<b[max1][90])) {max2=max1;max1=i;
		 }
		 
	 }
	
	 
	 	printf("%s %d\n",&b[max1][90],a[max1][2]);
	 	printf("%s %d\n",&b[max2][90],a[max2][2]);
	 	printf("%s %d\n \n",&b[max3][90],a[max3][2]);
	max1=0,max2=0,max3=0;
	 for(int i=1;i<=n;i++)
	 {
	 	
	 	if	(a[i][3]>a[max3][3] or (a[i][3]==a[max3][3]&&b[i][90]<b[max3][90])) max3=i;
	  if(a[i][3]>a[max2][3] or (a[i][3]==a[max2][3]&&b[i][90]<b[max2][90])) {max3=max2;max2=i;}
		 
	 	 if(a[i][3]>a[max1][3]  or (a[i][3]==a[max1][3]&&b[i][90]<b[max1][90])) {max2=max1;max1=i;
		 }
		 
	 }
	
	 
	 	printf("%s %d\n",&b[max1][90],a[max1][3]);
	 	printf("%s %d\n",&b[max2][90],a[max2][3]);
	 	printf("%s %d\n \n",&b[max3][90],a[max3][3]);
	
    }
	return 0;
}
