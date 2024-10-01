//编写函数，建立有序表，利用二叉排序树的插入算法建立二叉排序树；在以上二叉排序树中删除某一指定关键字元素；采用折半查找实现某一已知的关键字的查找(采用顺序表存储结构)


#include <iostream>
using namespace std;
struct TreeNode {
    int key;
    TreeNode* left;
    TreeNode* right;

    TreeNode(int value) : key(value), left(nullptr), right(nullptr) {}
};


class BinarySearchTree {
private:
    TreeNode* root;

    TreeNode* insert(TreeNode* node, int key) {
        if (node == nullptr) {
            return new TreeNode(key);
        }

        if (key < node->key) {
            node->left = insert(node->left, key);
        } else if (key > node->key) {
            node->right = insert(node->right, key);
        }

        return node;
    }

    // 删除指定关键字元素的辅助函数
    TreeNode* remove(TreeNode* node, int key) {
        if (node == nullptr) {
            return nullptr;
        }

        if (key < node->key) {
            node->left = remove(node->left, key);
        } else if (key > node->key) {
            node->right = remove(node->right, key);
        } else {
            // 找到要删除的节点

            // 情况1: 没有子节点或只有一个子节点
            if (node->left == nullptr) {
                TreeNode* temp = node->right;
                delete node;
                return temp;
            } else if (node->right == nullptr) {
                TreeNode* temp = node->left;
                delete node;
                return temp;
            }

            // 情况2: 有两个子节点，找到右子树中最小的节点替代当前节点
            TreeNode* temp = findMin(node->right);
            node->key = temp->key;
            node->right = remove(node->right, temp->key);
        }

        return node;
    }

    // 辅助函数：找到树中最小的节点
    TreeNode* findMin(TreeNode* node) {
        while (node->left != nullptr) {
            node = node->left;
        }
        return node;
    }

   bool binarySearch(TreeNode* node, int key) {
        if (node == nullptr) {
            return false;
        }

        if (node->key == key) {
            return true;
        } else if (key < node->key) {
            return binarySearch(node->left, key);
        } else {
            return binarySearch(node->right, key);
        }
    }

    // 中序遍历并输出有序表的辅助函数
    void inorderTraversal(TreeNode* node) {
        if (node != nullptr) {
            inorderTraversal(node->left);
            std::cout << node->key << " ";
            inorderTraversal(node->right);
        }
    }

public:
    BinarySearchTree() : root(nullptr) {}

    void insert(int key) {
        root = insert(root, key);
    }

   
    void remove(int key) {
        root = remove(root, key);
    }

   
    bool search(int key) {
        return binarySearch(root, key);
    }

    void printSortedArray() {
        cout << "有序表: ";
        inorderTraversal(root);
        cout << "\n";
    }
};

int main() {
    BinarySearchTree bst;

    
    int n;
    cout<<"请输入想要的数据长度"<<endl;
    cin>>n;
     int sortedArray[50];
     cout<<"请依次输入"<<n<<"个数据"<<endl;

     for(int i=0;i<n;i++)
     {
      cin>>sortedArray[i];
     }
    
   
    
    for (int i = 0; i < n; ++i) {
        bst.insert(sortedArray[i]);
    }
cout<<"请输入想要删除的指定关键字元素"<<endl;
    
    int c;
    cin>>c;
    bst.remove(c);
bst.printSortedArray();
    // 采用折半查找实现已知关键字的查找
    int k;
    cout<<"请输入想要查找的指定关键字元素"<<endl;
    cin>>k;
    bool found = bst.search(k);

    if (found) {
        cout << "关键字 " << k << " 在有序表中找到了。\n";
    } else {
        cout << "关键字 " << k << " 在有序表中未找到。\n";
    }
system("pause");
    return 0;
}
