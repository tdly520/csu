#include <stdio.h>
#include <stdlib.h>

// 定义木块结构体
typedef struct {
    int length;
    int weight;
} WoodBlock;

// 比较函数，用于qsort排序
int compare(const void *a, const void *b) {
    WoodBlock *blockA = (WoodBlock *)a;
    WoodBlock *blockB = (WoodBlock *)b;
    if (blockA->length == blockB->length) {
        return blockB->weight - blockA->weight; // 重量降序
    }
    return blockA->length - blockB->length; // 长度升序
}

// 计算最小准备时间函数
int min_preparation_time(int n, WoodBlock wood_blocks[]) {
    // 对木块数组进行排序
    qsort(wood_blocks, n, sizeof(WoodBlock), compare);
    
    // 初始化准备时间
    int preparation_time = 0;
    int a[n+1]={0};
    int sum=n;
    int m=0,i=0;
    // 跟踪上一个木块的长度和重量
   
    while(sum>0)
    { 
    	sum=0;
	preparation_time ++;
    m=0;
	while(a[m]!=0)
	{
		m++;
	}
	 int prev_length = wood_blocks[m].length;
    int prev_weight = wood_blocks[m].weight;
    for (int i = m; i < n; i++) {
    	
        int curr_length = wood_blocks[i].length;
        int curr_weight = wood_blocks[i].weight;
        if (curr_length >= prev_length && curr_weight >= prev_weight && a[i]==0) {
            // 不需要额外的准备时间
            prev_length = curr_length;
            prev_weight = curr_weight;
            a[i]=1;
        } else {
            // 需要额外的准备时间
            if(a[i]==0) {sum++;
			}
            
        }
    }
    
    }
    return preparation_time;
}

int main() {
    int n;
    while (scanf("%d", &n) != EOF) {
        WoodBlock wood_blocks[n];
        for (int i = 0; i < n; i++) {
            scanf("%d %d", &wood_blocks[i].length, &wood_blocks[i].weight);
        }
        printf("%d\n", min_preparation_time(n, wood_blocks));
    }
    return 0;
}

