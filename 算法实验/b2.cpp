#include <stdio.h>
#include <stdlib.h>

// ����ľ��ṹ��
typedef struct {
    int length;
    int weight;
} WoodBlock;

// �ȽϺ���������qsort����
int compare(const void *a, const void *b) {
    WoodBlock *blockA = (WoodBlock *)a;
    WoodBlock *blockB = (WoodBlock *)b;
    if (blockA->length == blockB->length) {
        return blockB->weight - blockA->weight; // ��������
    }
    return blockA->length - blockB->length; // ��������
}

// ������С׼��ʱ�亯��
int min_preparation_time(int n, WoodBlock wood_blocks[]) {
    // ��ľ�������������
    qsort(wood_blocks, n, sizeof(WoodBlock), compare);
    
    // ��ʼ��׼��ʱ��
    int preparation_time = 0;
    int a[n+1]={0};
    int sum=n;
    int m=0,i=0;
    // ������һ��ľ��ĳ��Ⱥ�����
   
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
            // ����Ҫ�����׼��ʱ��
            prev_length = curr_length;
            prev_weight = curr_weight;
            a[i]=1;
        } else {
            // ��Ҫ�����׼��ʱ��
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

