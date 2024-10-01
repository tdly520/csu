#include <stdio.h>
#include <stdlib.h>
#include <time.h>
void HeapAdjust(int a[],int s,int m)//一次筛选的过程
{
    int rc,j;
    rc=a[s];
    for(j=2*s;j<=m;j=j*2)//通过循环沿较大的孩子结点向下筛选
    {
        if(j<m&&a[j]<a[j+1]) j++;//j为较大的记录的下标
        if(rc>a[j]) break;
        a[s]=a[j];s=j;
    }
    a[s]=rc;//插入
}
void HeapSort(int a[],int n)
{
    int temp,i,j;
    for(i=n/2;i>0;i--)//通过循环初始化顶堆
    {
        HeapAdjust(a,i,n);
    }
    for(i=n;i>0;i--)
    {
        temp=a[1];
        a[1]=a[i];
        a[i]=temp;//将堆顶记录与未排序的最后一个记录交换
        HeapAdjust(a,1,i-1);//重新调整为顶堆
    }
}



void Merge(int A[], int left, int mid, int right)             //合并操作的代码实现
{
	int *B = new int[right - left + 1];                       //申请一个辅助数组B[]，与传递过来的序列数组等长
	//图中的三个辅助标记（工作指针）
	int i = left;                                             //指向待排序子序列数组A[left:mid]中当前待比较的元素
	int j = mid + 1;                                          //指向待排序子序列数组A[mid+1:right]中当前待比较的元素
	int k = 0;                                                //k指向辅助数组B[]中待放置元素的位置

	while (i <= mid && j <= right)                             //当i和j都指向未超过数组范围的时候
	{                                                          //从小到大排序，将A[i]和A[j]中的较小元素放入B[]中
		if (A[i] <= A[j])                                      //当前半部分数组A[left:mid]的值不大于后半部分数组A[mid+1:right]的值时，将前半部分数组辅助标记对应的值存入辅助数组中（具有稳定性）
			B[k++] = A[i++];                                   //存入辅助数组B[]中，且与之对应的辅助标记后移
		else                                                   //否则将后半部分辅助标记对应的值存入B[]中
			B[k++] = A[j++];                                   //存入辅助数组且与之对应的辅助标记后移
	}

	while (i <= mid)                                           //对序列A[left:mid]剩余的部分依次进行处理，与图中的（5）对应
		B[k++] = A[i++];                                       //将辅助标记对应的值存入辅助数组中且辅助标记后移

	while (j <= right)                                         //对序列A[mid+1:right]剩余的部分依次进行处理
		B[k++] = A[j++];                                       //将辅助标记对应的值存入辅助数组中且辅助标记后移  

	for (i = left, k = 0; i <= right; i++)                     //将合并后的序列复制到原来的A[]序列
		A[i] = B[k++];

	delete[] B;                                                //释放动态创建的辅助数组空间
}


//递归形式的归并排序算法
void MergeSort(int A[], int left, int right)                   //归并排序
{
	if (left < right)                                          //当数组内的元素数大于1时进行二分操作，只有一个元素的时候，不作任何处理直接结束
	{
		int mid;
		mid = (left + right) / 2;                              //计算中间位置
		MergeSort(A, left, mid);                               //对数组A[left:mid]中的元素进行归并排序
		MergeSort(A, mid + 1, right);                          //对数组A[mid+1:right]中的元素进行归并排序
		Merge(A, left, mid, right);                            //进行合并操作
	}
}

void print(int a[],int n)
{
  for(int i=1;i<=n;i++)
  {
    printf("%d ",a[i]);

  }
  printf("\n");
}
int main()
{srand((unsigned int)time(NULL));
  int a[6];
  for(int i=1;i<=5;i++)
  {
    

a[i] = rand() % 100 + 1;//生成1~100的随机数

printf("%d ",a[i]);
  }
  printf("\n");
  int n=5;
  int d[5];

//HeapSort(a,n);
MergeSort(a,1,n);
print(a,n);
system("pause");
	return 0;
}