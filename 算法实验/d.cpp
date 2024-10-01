#include <stdio.h>
#include <stdbool.h>

int a[1001];
int dp[1001];  // ��̬�滮���飬dp[i]��ʾ��a[i]��β������������еĳ���

// �Ƚ��������Ĵ�С
bool duibi(int x, int y) {
    return x < y;
}

void length(int n) {
    for (int i = 0; i < n; i++) {
        scanf("%d", &a[i]);
    }

    // ��ʼ����̬�滮����
    for (int i = 0; i < n; i++) {
        dp[i] = 1;  // ÿ��Ԫ�ر������һ������Ϊ1�ĵ���������
    }

    // ��̬�滮���������������
    for (int i = 1; i < n; i++) {
        for (int j = 0; j < i; j++) {
            if (duibi(a[j], a[i])) {
                if (dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                }
            }
        }
    }

    // �ҳ�dp�����е����ֵ����Ϊ����������еĳ���
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

