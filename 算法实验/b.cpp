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
        WoodBlock *newBlocks = (WoodBlock *)malloc(n * sizeof(WoodBlock)); // ���������ڴ�Ų�����������ľ��
        for (int i = 0; i < n; i++) {
            scanf("%d %d", &blocks[i].length, &blocks[i].weight);
        }

        qsort(blocks, n, sizeof(WoodBlock), compare);

        int preparationTime = 1;
        int newBlocksSize = 0; // ������Ĵ�С

        for (int i = 1; i < n; i++) {
            if (blocks[i].length >= blocks[i - 1].length && blocks[i].weight >= blocks[i - 1].weight) {
                continue;
            }
            newBlocks[newBlocksSize++] = blocks[i]; // ��������������ľ�����������
        }

        while (newBlocksSize > 0) { // ��������鲻Ϊ�գ���������
            preparationTime++; // ����׼��ʱ��
            int tempSize = 0; // ��ʱ�������ڴ���µĲ�����������ľ��
            for (int i = 1; i < newBlocksSize; i++) {
                if (newBlocks[i].length >= newBlocks[i - 1].length && newBlocks[i].weight >= newBlocks[i - 1].weight) {
                    continue;
                }
                newBlocks[tempSize++] = newBlocks[i]; // ���������в�����������ľ�������ʱ����
            }
            newBlocksSize = tempSize; // ����������Ĵ�С
        }

        printf("%d\n", preparationTime);

        free(blocks);
        free(newBlocks);
    }

    return 0;
}

