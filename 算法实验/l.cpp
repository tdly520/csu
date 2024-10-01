#include<stdio.h>
#include<math.h>

#define MAX 505
#define INF 0x3f3f3f3f
typedef long long ll;
using namespace std;

int n, m, in[MAX], ans[MAX];
vector<int> adj[MAX];

void topo() {
    for (int i = 1; i <= n; i++) {
        int pos;
        for (pos = 1; pos <= n; pos++) {
            if (in[pos] == 0) break;
        }
        ans[i] = pos;
        in[pos]--;
        for (int j = 0; j < adj[pos].size(); j++) {
            int id = adj[pos][j];
            in[id]--;
        }
    }
    for (int i = 1; i <= n; i++) {
        printf("%d ", ans[i]);
    }
    printf("\n");
}

int main() {
    while (scanf("%d %d", &n, &m) != EOF) {
        memset(in, 0, sizeof(in));
        memset(ans, 0, sizeof(ans));
        for (int i = 0; i < MAX; i++) {
            adj[i].clear();
        }

        int a, b;
        for (int i = 0; i < m; i++) {
            scanf("%d %d", &a, &b);
            adj[a].push_back(b);
            in[b]++;
        }

        for (int i = 1; i <= n; i++) {
            sort(adj[i].begin(), adj[i].end());
        }

        topo();
    }
    return 0;
}

