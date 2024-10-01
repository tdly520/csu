#include <iostream>
#include <vector>

using namespace std;

// ���������������
int dfs(int i, int j, int n, vector<vector<int> >& grid, int r, int c) {
    // �����ǰ�����ǽ�������
    if (grid[i][j] == 2) {
        // ������пո��Ѿ�������·����Ч
        if (n == 0) {
            return 1;
        }
        return 0;
    }

    int t = grid[i][j], res = 0;
    grid[i][j] = -1; // ���Ϊ�ѷ���
    int dir[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    for (int k = 0; k < 4; k++) {
        int ni = i + dir[k][0];
        int nj = j + dir[k][1];
        if (ni >= 0 && ni < r && nj >= 0 && nj < c && (grid[ni][nj] == 0 || grid[ni][nj] == 2)) {
            res += dfs(ni, nj, n - 1, grid, r, c);
        }
    }
    grid[i][j] = t; // �ָ����ӵ�ԭʼֵ
    return res;
}

// ������
int uniquePathsIII(vector<vector<int> >& grid) {
    int r = grid.size(), c = grid[0].size();
    int si = 0, sj = 0, n = 0;
    for (int i = 0; i < r; i++) {
        for (int j = 0; j < c; j++) {
            if (grid[i][j] == 0) {
                n++;
            } else if (grid[i][j] == 1) {
                n++;
                si = i;
                sj = j;
            }
        }
    }
    return dfs(si, sj, n, grid, r, c);
}

// ���Ժ���
int main() {
    // �ֶ�������������
    vector<vector<int>  > grid;
    cout << "�����������������������";
    int rows, cols;
    cin >> rows >> cols;

    cout << "��������������Ԫ�أ�0��ʾ�ո�1��ʾ��㣬2��ʾ�յ㣬-1��ʾ�ϰ�����\n";
    for (int i = 0; i < rows; i++) {
        vector<int> row;
        for (int j = 0; j < cols; j++) {
            int element;
            cin >> element;
            row.push_back(element);
        }
        grid.push_back(row);
    }

    cout << "Ψһ·��������" << uniquePathsIII(grid) << endl;

    return 0;
}

