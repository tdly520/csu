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
    // ���캯��
    Graph(int v) : vertices(v) {
        // ��ʼ���ڽӾ���
        for (int i = 0; i < MAX_SIZE; ++i) {
            for (int j = 0; j < MAX_SIZE; ++j) {
                adjacencyMatrix[i][j] = INT_MAX;
            }
        }
    }

    void addDirectedEdge(int from, int to, int weight) {
        adjacencyMatrix[from][to] = weight;
    }

    // Dijkstra�㷨�����·��
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

    // ��ӡ�����Դ�㵽ÿ����������·��������
    void printShortestPaths(int source, const vector<int>& distance, const vector<int>& parent) {
        cout << "�Ӷ��� " << source << " ������������·���ͳ��ȣ�" << endl;
        for (int i = 0; i < vertices; ++i) {
            if (i != source) {
                cout << "������ " << i << " �����·����";
                printPath(source, i, parent);
                cout << "�����ȣ�" << distance[i] << endl;
            }
        }
    }

private:
    // ��ӡ·��
    void printPath(int source, int destination, const vector<int>& parent) {
        if (destination == source) {
            cout << source << " ";
        } else if (parent[destination] == -1) {
            cout << "��·������";
        } else {
            printPath(source, parent[destination], parent);
            cout << destination << " ";
        }
    }
};

int main() {
    int numVertices, numEdges;

    cout << "�����붥�����ͱ�����";
    cin >> numVertices >> numEdges;

    
    Graph graph(numVertices);

    // �û���������ߺ�Ȩ��
    cout << "������ÿ���ߵ���㡢�յ��Ȩ�أ�" << endl;
    for (int i = 0; i < numEdges; ++i) {
        int from, to, weight;
        cin >> from >> to >> weight;
        graph.addDirectedEdge(from, to, weight);
    }

    // �û�����Դ����
    int source;
    cout << "������Դ���㣺";
    cin >> source;

    // ����Dijkstra�㷨��������·���ͳ���
    vector<int> distance, parent;
    graph.dijkstraShortestPath(source, distance, parent);
    graph.printShortestPaths(source, distance, parent);
system("pause");
    return 0;
}
