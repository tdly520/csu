#include<bits/stdc++.h>
#include<string>
using namespace std;
struct part{
	int month;
	int data;
	int year;
};
void bubble_sort(struct part * p,int num) ;
int main()
{
   int a;
    while(scanf("%d",&a)!= EOF )
    { 
    struct part b[a+1];
    for(int i=1;i<=a;i++)
    {
    	scanf("%d/%d/%d",&b[i].month,&b[i].data,&b[i].year);
	}
	bubble_sort(b,a);
	for(int i=1;i<=a;i++)
	{
		printf("%02d/%02d/%04d\n",b[i].month,b[i].data,b[i].year);
	}
	}
     
	

	return 0;
}


void bubble_sort(struct part *p,int num)
{
int i,j ;
struct part temp;
for(i=0;i<num-1;i++)
{
for(j=0;j<num-1-i;j++)
{
if(p[j].year>p[j+1].year)
{
temp =p[j];
p[j] =p[j+1];
p[j+1] =temp;
}
else if(p[j].year == p[j+1].year)
{
if(p[j].month >p[j+1].month)
{
temp =p[j];
p[j]=p[j+1];
p[j+1]=temp;
}
else if(p[j].month == p[j+1].month)
{
if(p[j].data > p[j+1].data)
{
temp =p[j];
p[j]=p[j+1];
p[j+1]=temp;
}
}
}
}
}
}
