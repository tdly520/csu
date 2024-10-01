#include <iostream>
#include <vector>
#include <algorithm>
#include <set>
using namespace std;

// 木块结构体，包含长度和重量
struct Block {
    int length;
    int weight;
};

// 排序函数，先按长度升序，如果长度相同则按重量降序
bool compare(const Block &a, const Block &b) {
    if (a.length == b.length) {
        return a.weight > b.weight; // 重量降序
    }
    return a.length < b.length; // 长度升序
}

bool match(const Block &a, const Block &b) {
    return (b.length >= a.length && b.weight >= a.weight);
}

int main() {
    int n;
    while (cin >> n) {
        vector<Block> blocks(n);
        set<int> matched;
        for (int i = 0; i < n; ++i) {
            cin >> blocks[i].length >> blocks[i].weight;
        }

        // 对木块进行排序
        sort(blocks.begin(), blocks.end(), compare);

        int prepare_time = 1; // 初始准备时间
        Block current_block = blocks[0];
        matched.insert(0);

        while (matched.size() < n) {
            int i = 0;
            while (matched.find(i) != matched.end()) {
                ++i;
            }
            if (i >= n) {
                break;
            }

            if (match(current_block, blocks[i])) {
                current_block = blocks[i];
                matched.insert(i);
            }

            if (i >= n - 1) {
                prepare_time++;
                break;
            }
        }

        // 输出最少准备时间
        cout << prepare_time << endl;
    }
    return 0;
}

