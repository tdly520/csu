#include <iostream>
#include <climits>
#include <vector>
#include <set>

using namespace std;

const int MAX_SIZE = 100;

class Graph {
private:
    int vertices;
    int adjacencyMatrix[MAX_SIZE][MAX_SIZE];

public:
    // 构造函数
    Graph(int v) : vertices(v) {
        // 初始化邻接矩阵
        for (int i = 0; i < MAX_SIZE; ++i) {
            for (int j = 0; j < MAX_SIZE; ++j) {
                adjacencyMatrix[i][j] = INT_MAX;
            }
        }
    }

    void addDirectedEdge(int from, int to, int weight) {
        adjacencyMatrix[from][to] = weight;
    }

    // Dijkstra算法求最短路径
    void dijkstraShortestPath(int source, vector<int>& distance, vector<int>& parent) {
        set<pair<int, int>> pq; 

      
        distance.assign(vertices, INT_MAX);
        parent.assign(vertices, -1);

       
        pq.insert({0, source});
        distance[source] = 0;

        while (!pq.empty()) {
            int u = pq.begin()->second;
            pq.erase(pq.begin());

            for (int v = 0; v < vertices; ++v) {
                if (adjacencyMatrix[u][v] != INT_MAX) {
                    int weight = adjacencyMatrix[u][v];
                    if (distance[u] + weight < distance[v]) {
                        pq.erase({distance[v], v});
                        distance[v] = distance[u] + weight;
                        parent[v] = u;
                        pq.insert({distance[v], v});
                    }
                }
            }
        }
    }

    // 打印输出从源点到每个顶点的最短路径及长度
    void printShortestPaths(int source, const vector<int>& distance, const vector<int>& parent) {
        cout << "从顶点 " << source << " 到各顶点的最短路径和长度：" << endl;
        for (int i = 0; i < vertices; ++i) {
            if (i != source) {
                cout << "到顶点 " << i << " 的最短路径：";
                printPath(source, i, parent);
                cout << "，长度：" << distance[i] << endl;
            }
        }
    }

private:
    // 打印路径
    void printPath(int source, int destination, const vector<int>& parent) {
        if (destination == source) {
            cout << source << " ";
        } else if (parent[destination] == -1) {
            cout << "无路径到达";
        } else {
            printPath(source, parent[destination], parent);
            cout << destination << " ";
        }
    }
};

int main() {
    int numVertices, numEdges;

    cout << "请输入顶点数和边数：";
    cin >> numVertices >> numEdges;

    
    Graph graph(numVertices);

    // 用户输入有向边和权重
    cout << "请输入每条边的起点、终点和权重：" << endl;
    for (int i = 0; i < numEdges; ++i) {
        int from, to, weight;
        cin >> from >> to >> weight;
        graph.addDirectedEdge(from, to, weight);
    }

    // 用户输入源顶点
    int source;
    cout << "请输入源顶点：";
    cin >> source;

    // 运行Dijkstra算法并输出最短路径和长度
    vector<int> distance, parent;
    graph.dijkstraShortestPath(source, distance, parent);
    graph.printShortestPaths(source, distance, parent);
system("pause");
    return 0;
}
