#include <stdio.h>
#include <stdbool.h>

void sieveOfEratosthenes(int n) {
    bool isPrime[n+1];
    for (int i = 0; i <= n; i++) {
        isPrime[i] = true;  // �ȼ�����������������
    }

    // 0��1�������������Ϊ������
    isPrime[0] = false;
    isPrime[1] = false;

    // ��ʼɸѡ����
    for (int p = 2; p * p <= n; p++) {
        if (isPrime[p] == true) {
            // ��p�ı������Ϊ������
            for (int i = p * p; i <= n; i += p) {
                isPrime[i] = false;
            }
        }
    }

    
    for (int i = 2; i <= n; i++) {
        if (isPrime[i]) {
            printf("%d\n", i);
        }
    }
}

int main() {
    int N;
    while(scanf("%d", &N)!=EOF)
    {
    sieveOfEratosthenes(N);	
	}
    
    
    return 0;
}

