//归并排序 
//将给定的数分成两个子数组——>一直到分成单位为2的子数组
//对子数组进行排序
//合并成原来长度的父数组 
#include<stdlib.h>
void sort(int a[],int len)
{
	void merge(int a[], int L[], int R[], int l, int r); 
	if(len>1)
	{
		int mid=len/2;
		int *L=(int *)malloc(sizeof(int)*mid);//定义俩数组 
		int *R=(int *)malloc(sizeof(int)*(len-mid));// 来存放子数组
		for(int i=0;i<mid;i++)
		{
			L[i]=a[i];//把左半部分放到L数组 
		} 
		for(int j=mid;j<len;j++)
		{
			R[j-mid]=a[j];//把右半部分放到R数组 
		} 
		sort(L,mid);//继续分 继续归并 （分成单位为2的子数组左右为1单位） 
		sort(R,len-mid); //进行merge函数 
	  	merge(a,L,R,mid,len-mid);//排序+合并函数
		free(L);
		free(R); 
	}
 } 
 void merge(int a[],int L[],int R[],int l,int r) 
 {
 	int i=0,j=0,k=0;
 	while(i<l&&j<r)//比较子串第一个数的大小  开始比较单位为1的子串
 	{//放到上一级父串
	  if(L[i]<=R[j])
	  {
	  	a[k++]=L[i++];//此时的a是上一级的父串
		}
		else
		{
			a[k++]=R[j++];
		}
	 }
	 while(i<l)//把比较完剩下的数放到上一级父串后面
	 {
	 	a[k++]=L[i++];
	 }
	 while(j<r)
	 {
	 	a[k++]=R[j++];
	 } 
 }

