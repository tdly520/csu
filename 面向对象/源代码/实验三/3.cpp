
#include <iostream>
#include <queue>
using namespace std;


struct HuffmanNode {
    char data; 
    int frequency; 
    HuffmanNode *left, *right; 

    HuffmanNode(char data, int frequency) : data(data), frequency(frequency), left(nullptr), right(nullptr) {}
};

// �ݹ麯�������ڴӹ��������ĸ��ڵ㿪ʼ����ȡÿ��Ҷ�ӽڵ�Ĺ���������
void generateHuffmanCodes(HuffmanNode* root, string code, string huffmanCodes[]) {
    if (root == nullptr) {
        return;
    }

    // �����Ҷ�ӽڵ㣬���ַ��Ͷ�Ӧ�Ĺ������������������
    if (!root->left && !root->right) {
        huffmanCodes[root->data] = code;
    }

    // �ݹ��ȡ���������Ĺ���������
    generateHuffmanCodes(root->left, code + "0", huffmanCodes);
    generateHuffmanCodes(root->right, code + "1", huffmanCodes);
}

HuffmanNode* buildHuffmanTree() {
    int n;
    cout << "�������ַ�����"<<endl;
    cin >> n;
    int frequency[n];
    cout << "������ÿ���ַ���Ȩֵ" << endl;
    for (int i = 0; i < n; ++i) {
        cout << "�ַ� " << i + 1 << " ��Ȩֵ ";
        cin >> frequency[i];
    }

    // ����һ�����ȶ������洢�ڵ㣬����Ƶ�ʴ�С��������
    priority_queue<HuffmanNode*, vector<HuffmanNode*>, greater<HuffmanNode*>> minHeap;

    // ��Ȩֵת��Ϊ�ڵ㣬���������ȶ���
    for (int i = 0; i < n; ++i) {
        HuffmanNode* node = new HuffmanNode('A' + i, frequency[i]); // ����ĸ��ʾ�ַ�
        minHeap.push(node);
    }

    
    while (minHeap.size() > 1) {
        
        HuffmanNode* left = minHeap.top();
        minHeap.pop();

        HuffmanNode* right = minHeap.top();
        minHeap.pop();

        // ����һ���½ڵ㣬��Ƶ��Ϊ�����ӽڵ�Ƶ��֮��
        int totalFrequency = left->frequency + right->frequency;
        HuffmanNode* newNode = new HuffmanNode('$', totalFrequency); // '$' ��ʾ�ڲ��ڵ�

        // ��ȡ���������ڵ���Ϊ�½ڵ�������ӽڵ�
        newNode->left = left;
        newNode->right = right;

        // ���½ڵ�������ȶ���
        minHeap.push(newNode);
    }

    // ���ظ��ڵ�
    return minHeap.top();
}

int main() {
    
    HuffmanNode* root = buildHuffmanTree();

    
    string huffmanCodes[256]; // �ٶ��ַ���Χ��0-255֮��
    generateHuffmanCodes(root, "", huffmanCodes);

   
    cout << "�ַ���Ӧ�Ĺ��������룺" << endl;
    for (int i = 0; i < 256; ++i) {
        if (!huffmanCodes[i].empty()) {
            cout << char(i) << ": " << huffmanCodes[i] << endl;
        }
    }
system("pause");
    return 0;
}

