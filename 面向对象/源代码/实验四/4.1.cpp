#include <iostream>
#include <vector>
#include <climits>

using namespace std;


#define MAX_VERTICES 100


#define INF INT_MAX

class WeightedGraph {
private:
    int vertices;  // ͼ�Ķ�����
    vector<vector<int>> adjacencyMatrix;  // �ڽӾ���

public:
    // ���캯��
    WeightedGraph(int v) : vertices(v), adjacencyMatrix(v, vector<int>(v, INF)) {}

    // ��ʼ���ڽӾ����ʾ�������Ȩͼ
    void initializeGraph() {
        adjacencyMatrix.assign(vertices, vector<int>(vertices, INF));
    }

    // �����ڽӾ����ʾ�������Ȩͼ
    void addEdge(int from, int to, int weight) {
        adjacencyMatrix[from][to] = weight;
        adjacencyMatrix[to][from] = weight;
    }

    // ����ڽӾ����ʾ�������Ȩͼ
    void printGraph() {
        cout << "�ڽӾ����ʾ�������Ȩͼ��" << endl;
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

    // Prim�㷨������С������
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

// ����߼�����
void printEdges(const vector<pair<int, int>>& edges) {
    cout << "��С�������ı߼����飺" << endl;
    for (const auto& edge : edges) {
        cout << edge.first << " - " << edge.second << endl;
    }
}

int main() {
    int vertices, edges;
    
    // ���붥�����ͱ���
    cout << "�����붥������";
    cin >> vertices;
    
    WeightedGraph graph(vertices);
    
   
    graph.initializeGraph();
    
    
    cout << "�����������";
    cin >> edges;
    cout << "������ߵ���Ϣ����� �յ� Ȩ�أ���" << endl;
    for (int i = 0; i < edges; ++i) {
        int from, to, weight;
        cin >> from >> to >> weight;
        graph.addEdge(from, to, weight);
    }
    
   
    graph.printGraph();
    
    // ʹ��Prim�㷨������С������
    vector<pair<int, int>> minSpanningTree = graph.primMST();
    
    
    printEdges(minSpanningTree);
system("pause");
    return 0;
}
