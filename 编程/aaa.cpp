//�鲢���� 
//�����������ֳ����������顪��>һֱ���ֳɵ�λΪ2��������
//���������������
//�ϲ���ԭ�����ȵĸ����� 
#include<stdlib.h>
void sort(int a[],int len)
{
	void merge(int a[], int L[], int R[], int l, int r); 
	if(len>1)
	{
		int mid=len/2;
		int *L=(int *)malloc(sizeof(int)*mid);//���������� 
		int *R=(int *)malloc(sizeof(int)*(len-mid));// �����������
		for(int i=0;i<mid;i++)
		{
			L[i]=a[i];//����벿�ַŵ�L���� 
		} 
		for(int j=mid;j<len;j++)
		{
			R[j-mid]=a[j];//���Ұ벿�ַŵ�R���� 
		} 
		sort(L,mid);//������ �����鲢 ���ֳɵ�λΪ2������������Ϊ1��λ�� 
		sort(R,len-mid); //����merge���� 
	  	merge(a,L,R,mid,len-mid);//����+�ϲ�����
		free(L);
		free(R); 
	}
 } 
 void merge(int a[],int L[],int R[],int l,int r) 
 {
 	int i=0,j=0,k=0;
 	while(i<l&&j<r)//�Ƚ��Ӵ���һ�����Ĵ�С  ��ʼ�Ƚϵ�λΪ1���Ӵ�
 	{//�ŵ���һ������
	  if(L[i]<=R[j])
	  {
	  	a[k++]=L[i++];//��ʱ��a����һ���ĸ���
		}
		else
		{
			a[k++]=R[j++];
		}
	 }
	 while(i<l)//�ѱȽ���ʣ�µ����ŵ���һ����������
	 {
	 	a[k++]=L[i++];
	 }
	 while(j<r)
	 {
	 	a[k++]=R[j++];
	 } 
 }

