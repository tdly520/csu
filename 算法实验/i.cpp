#include <stdio.h>
#include <stdbool.h>

void sieveOfEratosthenes(int n) {
    bool isPrime[n+1];
    for (int i = 0; i <= n; i++) {
        isPrime[i] = true;  // 先假设所有数都是素数
    }

    // 0和1不是素数，标记为非素数
    isPrime[0] = false;
    isPrime[1] = false;

    // 开始筛选素数
    for (int p = 2; p * p <= n; p++) {
        if (isPrime[p] == true) {
            // 将p的倍数标记为非素数
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

