#include <stdio.h>
#include <stdlib.h>
#include <time.h>
void insertSort(int a[], int n)
{
	int temp, j, k;
	for (int i = 0; i < n; i++)
	{
		temp = a[i];
		for (j = i - 1; j >= 0; j--)
		{
			if (a[j] < temp)
				break;
		}
		if (j != i - 1)
		{
			for (k = i - 1; k > j; k--)
			{
				a[k + 1] = a[k];
			}
			a[k + 1] = temp;
		}
	}
}
void twoLineInsertSort(int a[],int d[],int n)
{
   int first=0,final=0;
   int k=0;
   d[0]=a[0];
   for(int i=1;i<n;i++)
   {
    if(a[i]<d[first])
    {
      first=(first-1+n)%n;
      d[first]=a[i];
    }
    else if(a[i]>d[final])
    {
      final=(final+1+n)%n;
      d[final]=a[i];
    }
    else {
      k = (final + 1 + n) % n;
           
            while (d[((k - 1) + n) % n] > a[i]) {
                d[(k + n) % n] =d[(k - 1 + n) % n];
                k = (k - 1 + n) % n;
            }
            
            d[(k + n) % n] = a[i];
           
            final = (final + 1 + n) % n;
    }





   }
   for(int j=0;j<n;j++)
   {
    a[j]=d[(j+first)%n];
   }
}


void Swap(int &x, int &y) {
    int temp;
    
    temp = x;
    x = y;
    y = temp;
}

void shell(int a[],int n)
{
  int temp;
  int j,i,s;
for( j=n/2;j>=1;j=j/2)
{
  for(i=j;i<n;i++)
  {
   temp=a[i];
   for( s=i-j;s>=0&&temp<a[s];s=s-j){
				a[s+j]=a[s];	
			} 
			a[s+j]=temp; 
  }
}

}

void BubbleSort(int a[],int n)
{int temp;
  for(int i=1;i<n;i++)
  {
    for(int j=0;j<n-i;j++)
    {
      if(a[j+1]<a[j])
      {
         Swap(a[j+1],a[j]);
      }
    }
  }
}

void twoBubbleSort(int a[],int n)
{
   int left, right, shift, i; 
    
    left = 0;
    right = n - 1;
    shift = 1;
    while(left < right) { 
        for(i = left; i < right; i++) {
            if(a[i] > a[i+1]) { 
                Swap(a[i], a[i+1]);
                shift = i;
            }
        }
        right = shift;
        for(i = right-1; i >= left; i--) { 
            if(a[i] > a[i+1]) { 
                Swap(a[i], a[i+1]);
                shift = i + 1;
            }
        }
        left = shift;
    }


}
void Quick_Sort(int a[], int begin, int end)
{
    if(begin > end)
        return;
    int temp = a[begin];
    int i = begin;
    int j = end;
    while(i != j){
        while(a[j] >= temp && j > i)
            j--;
        while(a[i] <= temp && j > i)
            i++;
        if(j > i){
            
            Swap(a[i],a[j]);
            
        }
    }
    a[begin] = a[i];
    a[i] = temp;
    Quick_Sort(a, begin, i-1);
    Quick_Sort(a, i+1, end);
}


void selectSort(int a[], int n)
{
	int i, j;
	int min; 
	int temp;
	for (i = 0; i < n - 1; ++i)
		min = i;
		for (j = i + 1; j < n; ++j)
		{
			if (a[j] < a[min])
			{
				min = j;
			}
		}
		
    Swap(a[min],a[i]);
		
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
  int a[5];
  for(int i=0;i<=4;i++)
  {
    

a[i] = rand() % 100 + 1;//生成1~100的随机数

printf("%d ",a[i]);
  }
  printf("\n");
  int n=5;
  int d[5];

//insertSort(a,n);
//twoLineInsertSort(a,d,n);
//shell(a,n);
//BubbleSort(a,n);
//twoBubbleSort(a,n);
//Quick_Sort(a,0,n-1);
selectSort(a,n);

print(a,n);
system("pause");
	return 0;
}