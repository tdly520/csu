#include <iostream>
#include <vector>
#include <algorithm>
#include <set>
using namespace std;

// ľ��ṹ�壬�������Ⱥ�����
struct Block {
    int length;
    int weight;
};

// ���������Ȱ������������������ͬ����������
bool compare(const Block &a, const Block &b) {
    if (a.length == b.length) {
        return a.weight > b.weight; // ��������
    }
    return a.length < b.length; // ��������
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

        // ��ľ���������
        sort(blocks.begin(), blocks.end(), compare);

        int prepare_time = 1; // ��ʼ׼��ʱ��
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

        // �������׼��ʱ��
        cout << prepare_time << endl;
    }
    return 0;
}

