#include <iostream>
#include <vector>
#include <climits>

using namespace std;


#define MAX_VERTICES 100


#define INF INT_MAX

class WeightedGraph {
private:
    int vertices;  // 图的顶点数
    vector<vector<int>> adjacencyMatrix;  // 邻接矩阵

public:
    // 构造函数
    WeightedGraph(int v) : vertices(v), adjacencyMatrix(v, vector<int>(v, INF)) {}

    // 初始化邻接矩阵表示的无向带权图
    void initializeGraph() {
        adjacencyMatrix.assign(vertices, vector<int>(vertices, INF));
    }

    // 建立邻接矩阵表示的无向带权图
    void addEdge(int from, int to, int weight) {
        adjacencyMatrix[from][to] = weight;
        adjacencyMatrix[to][from] = weight;
    }

    // 输出邻接矩阵表示的无向带权图
    void printGraph() {
        cout << "邻接矩阵表示的无向带权图：" << endl;
        for (int i = 0; i < vertices; ++i) {
            for (int j = 0; j < vertices; ++j) {
                if (adjacencyMatrix[i][j] == INF) {
                    cout << "INF ";
                } else {
                    cout << adjacencyMatrix[i][j] << " ";
                }
            }
            cout << endl;
        }
    }

    // Prim算法生成最小生成树
    vector<pair<int, int>> primMST() {
        vector<int> key(vertices, INF);
        vector<bool> inMST(vertices, false);
        vector<pair<int, int>> edges;

        key[0] = 0; 
        for (int count = 0; count < vertices - 1; ++count) {
            int u = -1; 
            for (int i = 0; i < vertices; ++i) {
                if (!inMST[i] && (u == -1 || key[i] < key[u])) {
                    u = i;
                }
            }

            inMST[u] = true;
            for (int v = 0; v < vertices; ++v) {
                if (adjacencyMatrix[u][v] != INF && !inMST[v] && adjacencyMatrix[u][v] < key[v]) {
                    key[v] = adjacencyMatrix[u][v];
                    edges.push_back({u, v});
                }
            }
        }

        return edges;
    }
};

// 输出边集数组
void printEdges(const vector<pair<int, int>>& edges) {
    cout << "最小生成树的边集数组：" << endl;
    for (const auto& edge : edges) {
        cout << edge.first << " - " << edge.second << endl;
    }
}

int main() {
    int vertices, edges;
    
    // 输入顶点数和边数
    cout << "请输入顶点数：";
    cin >> vertices;
    
    WeightedGraph graph(vertices);
    
   
    graph.initializeGraph();
    
    
    cout << "请输入边数：";
    cin >> edges;
    cout << "请输入边的信息（起点 终点 权重）：" << endl;
    for (int i = 0; i < edges; ++i) {
        int from, to, weight;
        cin >> from >> to >> weight;
        graph.addEdge(from, to, weight);
    }
    
   
    graph.printGraph();
    
    // 使用Prim算法生成最小生成树
    vector<pair<int, int>> minSpanningTree = graph.primMST();
    
    
    printEdges(minSpanningTree);
system("pause");
    return 0;
}
