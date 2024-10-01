#include <iostream>
#include <vector>

using namespace std;

// 深度优先搜索函数
int dfs(int i, int j, int n, vector<vector<int> >& grid, int r, int c) {
    // 如果当前格子是结束格子
    if (grid[i][j] == 2) {
        // 如果所有空格都已经过，则路径有效
        if (n == 0) {
            return 1;
        }
        return 0;
    }

    int t = grid[i][j], res = 0;
    grid[i][j] = -1; // 标记为已访问
    int dir[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    for (int k = 0; k < 4; k++) {
        int ni = i + dir[k][0];
        int nj = j + dir[k][1];
        if (ni >= 0 && ni < r && nj >= 0 && nj < c && (grid[ni][nj] == 0 || grid[ni][nj] == 2)) {
            res += dfs(ni, nj, n - 1, grid, r, c);
        }
    }
    grid[i][j] = t; // 恢复格子的原始值
    return res;
}

// 主函数
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

// 测试函数
int main() {
    // 手动输入网格数据
    vector<vector<int>  > grid;
    cout << "请输入网格的行数和列数：";
    int rows, cols;
    cin >> rows >> cols;

    cout << "请逐行输入网格元素（0表示空格，1表示起点，2表示终点，-1表示障碍）：\n";
    for (int i = 0; i < rows; i++) {
        vector<int> row;
        for (int j = 0; j < cols; j++) {
            int element;
            cin >> element;
            row.push_back(element);
        }
        grid.push_back(row);
    }

    cout << "唯一路径数量：" << uniquePathsIII(grid) << endl;

    return 0;
}

