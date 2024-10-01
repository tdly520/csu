//编写函数，建立二叉树的二叉链表；实现二叉树的前中后序的递归和非递归遍历算法。
#include <queue>
#include<stack>
#include <iostream>
using namespace std;
struct TreeNode {
    int data;
    TreeNode* left;
    TreeNode* right;

    TreeNode(int value) : data(value), left(nullptr), right(nullptr) {}
};


TreeNode* buildTree() {
    cout << "请输入根结点值: ";
    int rootValue;
    cin >> rootValue;

   TreeNode* root = new TreeNode(rootValue);
    queue<TreeNode*> nodeQueue;
    nodeQueue.push(root);

    while (!nodeQueue.empty()) {
        TreeNode* currentNode = nodeQueue.front();
        nodeQueue.pop();

        // Input left child
        cout << "输入左孩子值" << currentNode->data << " 输入-1代表结束: ";
        int leftValue;
        cin >> leftValue;
        if (leftValue != -1) {
            currentNode->left = new TreeNode(leftValue);
            nodeQueue.push(currentNode->left);
        }

        // Input right child
        cout << "输入右孩子值" << currentNode->data << " 输入-1代表结束: ";
        int rightValue;
        cin >> rightValue;
        if (rightValue != -1) {
            currentNode->right = new TreeNode(rightValue);
            nodeQueue.push(currentNode->right);
        }
    }

    return root;
}

// 递归前序遍历
void recursivePreorder(TreeNode* root) {
    if (root) {
        cout << root->data << " ";
        recursivePreorder(root->left);
        recursivePreorder(root->right);
    }
}
//递归中序遍历
void recursiveInorder(TreeNode* root) {
    if (root) {
        recursiveInorder(root->left);
        cout << root->data << " ";
        recursiveInorder(root->right);
    }
}

// 递归后序遍历
void recursivePostorder(TreeNode* root) {
    if (root) {
        recursivePostorder(root->left);
        recursivePostorder(root->right);
        cout << root->data << " ";
    }
}
//非递归前序遍历
void iterativePreorder(TreeNode* root) {
    if (!root) return;

    stack<TreeNode*> nodeStack;
    nodeStack.push(root);

    while (!nodeStack.empty()) {
        TreeNode* node = nodeStack.top();
        nodeStack.pop();
        cout << node->data << " ";

        if (node->right) {
            nodeStack.push(node->right);
        }
        if (node->left) {
            nodeStack.push(node->left);
        }
    }
}

// 非递归中序遍历
void iterativeInorder(TreeNode* root) {
    if (!root) return;

    stack<TreeNode*> nodeStack;
    TreeNode* current = root;

    while (current != nullptr || !nodeStack.empty()) {
        while (current != nullptr) {
            nodeStack.push(current);
            current = current->left;
        }
        current = nodeStack.top();
        nodeStack.pop();
        cout << current->data << " ";
        current = current->right;
    }
}

// 非递归后序遍历
void iterativePostorder(TreeNode* root) {
    if (!root) return;

    stack<TreeNode*> nodeStack;
    stack<int> resultStack;
    nodeStack.push(root);

    while (!nodeStack.empty()) {
        TreeNode* node = nodeStack.top();
        nodeStack.pop();
        resultStack.push(node->data);

        if (node->left) {
            nodeStack.push(node->left);
        }
        if (node->right) {
            nodeStack.push(node->right);
        }
    }

    while (!resultStack.empty()) {
        cout << resultStack.top() << " ";
        resultStack.pop();
    }
}

int main() {
   TreeNode* root = buildTree();

    cout << "Recursive Preorder Traversal: ";
    cout<<"前序递归遍历"<<endl;
    recursivePreorder(root);
    cout << endl;
    cout<<"中序递归遍历"<<endl;
    recursiveInorder(root);
    cout << endl;
    cout<<"后续递归遍历"<<endl;
    recursivePostorder(root);
        cout << endl;
    cout<<"非递归前序遍历"<<endl;
        iterativePreorder(root);
        cout<<endl;
    cout<<"非递归中序遍历"<<endl;    
    iterativeInorder(root);
    cout<<endl;
    cout<<"非递归后序遍历"<<endl;
    iterativePostorder(root);
    cout<<endl;
    system("pause");
    return 0;
}
