#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int length;
    int weight;
} WoodBlock;

int compare(const void *a, const void *b) {
    WoodBlock *block1 = (WoodBlock *)a;
    WoodBlock *block2 = (WoodBlock *)b;
    
    if (block1->length != block2->length) {
        return block1->length - block2->length;
    }
    return block1->weight - block2->weight;
}

int main() {
    int n;
    while (scanf("%d", &n) != EOF) {
        WoodBlock *blocks = (WoodBlock *)malloc(n * sizeof(WoodBlock));
        WoodBlock *newBlocks = (WoodBlock *)malloc(n * sizeof(WoodBlock)); // 新数组用于存放不符合条件的木块
        for (int i = 0; i < n; i++) {
            scanf("%d %d", &blocks[i].length, &blocks[i].weight);
        }

        qsort(blocks, n, sizeof(WoodBlock), compare);

        int preparationTime = 1;
        int newBlocksSize = 0; // 新数组的大小

        for (int i = 1; i < n; i++) {
            if (blocks[i].length >= blocks[i - 1].length && blocks[i].weight >= blocks[i - 1].weight) {
                continue;
            }
            newBlocks[newBlocksSize++] = blocks[i]; // 将不符合条件的木块存入新数组
        }

        while (newBlocksSize > 0) { // 如果新数组不为空，继续遍历
            preparationTime++; // 增加准备时间
            int tempSize = 0; // 临时变量用于存放新的不符合条件的木块
            for (int i = 1; i < newBlocksSize; i++) {
                if (newBlocks[i].length >= newBlocks[i - 1].length && newBlocks[i].weight >= newBlocks[i - 1].weight) {
                    continue;
                }
                newBlocks[tempSize++] = newBlocks[i]; // 将新数组中不符合条件的木块存入临时变量
            }
            newBlocksSize = tempSize; // 更新新数组的大小
        }

        printf("%d\n", preparationTime);

        free(blocks);
        free(newBlocks);
    }

    return 0;
}

