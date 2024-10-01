
#include <iostream>
#include <queue>
using namespace std;


struct HuffmanNode {
    char data; 
    int frequency; 
    HuffmanNode *left, *right; 

    HuffmanNode(char data, int frequency) : data(data), frequency(frequency), left(nullptr), right(nullptr) {}
};

// 递归函数，用于从哈夫曼树的根节点开始，获取每个叶子节点的哈夫曼编码
void generateHuffmanCodes(HuffmanNode* root, string code, string huffmanCodes[]) {
    if (root == nullptr) {
        return;
    }

    // 如果是叶子节点，将字符和对应的哈夫曼编码存入数组中
    if (!root->left && !root->right) {
        huffmanCodes[root->data] = code;
    }

    // 递归获取左右子树的哈夫曼编码
    generateHuffmanCodes(root->left, code + "0", huffmanCodes);
    generateHuffmanCodes(root->right, code + "1", huffmanCodes);
}

HuffmanNode* buildHuffmanTree() {
    int n;
    cout << "请输入字符个数"<<endl;
    cin >> n;
    int frequency[n];
    cout << "请输入每个字符的权值" << endl;
    for (int i = 0; i < n; ++i) {
        cout << "字符 " << i + 1 << " 的权值 ";
        cin >> frequency[i];
    }

    // 创建一个优先队列来存储节点，按照频率从小到大排序
    priority_queue<HuffmanNode*, vector<HuffmanNode*>, greater<HuffmanNode*>> minHeap;

    // 将权值转换为节点，并加入优先队列
    for (int i = 0; i < n; ++i) {
        HuffmanNode* node = new HuffmanNode('A' + i, frequency[i]); // 用字母表示字符
        minHeap.push(node);
    }

    
    while (minHeap.size() > 1) {
        
        HuffmanNode* left = minHeap.top();
        minHeap.pop();

        HuffmanNode* right = minHeap.top();
        minHeap.pop();

        // 创建一个新节点，其频率为左右子节点频率之和
        int totalFrequency = left->frequency + right->frequency;
        HuffmanNode* newNode = new HuffmanNode('$', totalFrequency); // '$' 表示内部节点

        // 将取出的两个节点作为新节点的左右子节点
        newNode->left = left;
        newNode->right = right;

        // 将新节点加入优先队列
        minHeap.push(newNode);
    }

    // 返回根节点
    return minHeap.top();
}

int main() {
    
    HuffmanNode* root = buildHuffmanTree();

    
    string huffmanCodes[256]; // 假定字符范围在0-255之间
    generateHuffmanCodes(root, "", huffmanCodes);

   
    cout << "字符对应的哈夫曼编码：" << endl;
    for (int i = 0; i < 256; ++i) {
        if (!huffmanCodes[i].empty()) {
            cout << char(i) << ": " << huffmanCodes[i] << endl;
        }
    }
system("pause");
    return 0;
}

