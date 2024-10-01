#include <stdio.h>


#define mod 1000000007
long long dp[105][105];

int main()
{
    int k, l, i, j, x;
    while (scanf("%d%d", &k, &l) != EOF)
    {
        for (i = 0; i < k; i++)
            dp[1][i] = 1;
        for (i = 2; i <= l; i++)
            for (j = 0; j < k; j++)
                for (x = 0; x < k; x++)
                    if (x != j - 1 && x != j + 1)
                    {
                        dp[i][j] += dp[i - 1][x];
                        dp[i][j] %= mod;
                    }
        long long sum = 0;
        for (i = 1; i < k; i++)
        {
            sum += dp[l][i];
            sum %= mod;
        }
        printf("%lld\n", sum);
    }

    return 0;
}

