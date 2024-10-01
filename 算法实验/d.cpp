#include <stdio.h>
#include <stdbool.h>

int a[1001];
int dp[1001];  // 动态规划数组，dp[i]表示以a[i]结尾的最长递增子序列的长度

// 比较两个数的大小
bool duibi(int x, int y) {
    return x < y;
}

void length(int n) {
    for (int i = 0; i < n; i++) {
        scanf("%d", &a[i]);
    }

    // 初始化动态规划数组
    for (int i = 0; i < n; i++) {
        dp[i] = 1;  // 每个元素本身就是一个长度为1的递增子序列
    }

    // 动态规划计算最长递增子序列
    for (int i = 1; i < n; i++) {
        for (int j = 0; j < i; j++) {
            if (duibi(a[j], a[i])) {
                if (dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                }
            }
        }
    }

    // 找出dp数组中的最大值，即为最长递增子序列的长度
    int max = 0;
    for (int i = 0; i < n; i++) {
        if (dp[i] > max) {
            max = dp[i];
        }
    }

    printf("%d\n", max);
}

int main() {
    int n;
    while (scanf("%d", &n) != EOF) {
        length(n);
    }
    return 0;
}

