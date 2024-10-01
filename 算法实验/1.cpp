#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// Helper function to count the number of 0s and 1s in a given string
void getZerosOnes(int* zerosOnes, const char* str) {
    int length = strlen(str);
    for (int i = 0; i < length; i++) {
        zerosOnes[str[i] - '0']++;
    }
}

int findMaxForm(const char** strs, int strsSize, int m, int n) {
    int dp[m + 1][n + 1];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < strsSize; i++) {
        int zerosOnes[2] = {0, 0};
        getZerosOnes(zerosOnes, strs[i]);
        int zeros = zerosOnes[0], ones = zerosOnes[1];

        for (int j = m; j >= zeros; j--) {
            for (int k = n; k >= ones; k--) {
                dp[j][k] = (dp[j][k] > dp[j - zeros][k - ones] + 1) ? dp[j][k] : dp[j - zeros][k - ones] + 1;
            }
        }
    }

    return dp[m][n];
}

int main() {
    int m, n, strsSize;
    
    printf("������m��ֵ��");
    scanf("%d", &m);
    printf("������n��ֵ��");
    scanf("%d", &n);

    printf("�������ַ�������Ĵ�С��");
    scanf("%d", &strsSize);

    const char** strs = (const char**)malloc(strsSize * sizeof(char*));
    for (int i = 0; i < strsSize; i++) {
        strs[i] = (char*)malloc(101 * sizeof(char)); // ����ÿ���ַ�����󳤶�Ϊ100
        printf("�������ַ��� %d��", i + 1);
        scanf("%s", (char*)strs[i]);
    }

    int result = findMaxForm(strs, strsSize, m, n);
    printf("�����γɵ�����ַ���������: %d\n", result);

    for (int i = 0; i < strsSize; i++) {
        free((void*)strs[i]);
    }
    free(strs);

    return 0;
}

