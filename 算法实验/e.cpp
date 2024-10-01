#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define MAX_P 800
#define MAX_C 1450
#define INF INT_MAX

typedef struct {
    int node;
    int distance;
} Edge;

typedef struct {
    Edge edges[MAX_C];
    int edge_count;
} Node;

Node graph[MAX_P + 1];
int cow_pastures[MAX_P + 1];
int distances[MAX_P + 1][MAX_P + 1];
int min_distances[MAX_P + 1];

void dijkstra(int start, int P) {
    int dist[MAX_P + 1];
    int visited[MAX_P + 1] = {0};
    for (int i = 1; i <= P; i++) {
        dist[i] = INF;
    }
    dist[start] = 0;

    for (int i = 1; i <= P; i++) {
        int min_dist = INF, u = -1;
        for (int j = 1; j <= P; j++) {
            if (!visited[j] && dist[j] < min_dist) {
                min_dist = dist[j];
                u = j;
            }
        }
        if (u == -1) break;
        visited[u] = 1;

        for (int j = 0; j < graph[u].edge_count; j++) {
            int v = graph[u].edges[j].node;
            int weight = graph[u].edges[j].distance;
            if (!visited[v] && dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
            }
        }
    }

    for (int i = 1; i <= P; i++) {
        distances[start][i] = dist[i];
    }
}

int main() {
    int N,P,C;
    while (scanf("%d%d%d", &N,&P,&C) != EOF) {
        for (int i = 1; i <= N; i++) {
        scanf("%d", &cow_pastures[i]);
    }

    for (int i = 0; i <= P; i++) {
        graph[i].edge_count = 0;
    }

    for (int i = 0; i < C; i++) {
        int A, B, D;
        scanf("%d %d %d", &A, &B, &D);
        graph[A].edges[graph[A].edge_count].node = B;
        graph[A].edges[graph[A].edge_count].distance = D;
        graph[A].edge_count++;
        graph[B].edges[graph[B].edge_count].node = A;
        graph[B].edges[graph[B].edge_count].distance = D;
        graph[B].edge_count++;
    }

    for (int i = 1; i <= P; i++) {
        dijkstra(i, P);
    }

    int min_total_distance = INF;

    for (int i = 1; i <= P; i++) {
        int total_distance = 0;
        for (int j = 1; j <= N; j++) {
            total_distance += distances[cow_pastures[j]][i];
        }
        if (total_distance < min_total_distance) {
            min_total_distance = total_distance;
        }
    }

    printf("%d\n", min_total_distance);

    return 0;
}
    }


