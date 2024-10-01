//��д������������������ö����������Ĳ����㷨���������������������϶�����������ɾ��ĳһָ���ؼ���Ԫ�أ������۰����ʵ��ĳһ��֪�Ĺؼ��ֵĲ���(����˳���洢�ṹ)


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

    // ɾ��ָ���ؼ���Ԫ�صĸ�������
    TreeNode* remove(TreeNode* node, int key) {
        if (node == nullptr) {
            return nullptr;
        }

        if (key < node->key) {
            node->left = remove(node->left, key);
        } else if (key > node->key) {
            node->right = remove(node->right, key);
        } else {
            // �ҵ�Ҫɾ���Ľڵ�

            // ���1: û���ӽڵ��ֻ��һ���ӽڵ�
            if (node->left == nullptr) {
                TreeNode* temp = node->right;
                delete node;
                return temp;
            } else if (node->right == nullptr) {
                TreeNode* temp = node->left;
                delete node;
                return temp;
            }

            // ���2: �������ӽڵ㣬�ҵ�����������С�Ľڵ������ǰ�ڵ�
            TreeNode* temp = findMin(node->right);
            node->key = temp->key;
            node->right = remove(node->right, temp->key);
        }

        return node;
    }

    // �����������ҵ�������С�Ľڵ�
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

    // �����������������ĸ�������
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
        cout << "�����: ";
        inorderTraversal(root);
        cout << "\n";
    }
};

int main() {
    BinarySearchTree bst;

    
    int n;
    cout<<"��������Ҫ�����ݳ���"<<endl;
    cin>>n;
     int sortedArray[50];
     cout<<"����������"<<n<<"������"<<endl;

     for(int i=0;i<n;i++)
     {
      cin>>sortedArray[i];
     }
    
   
    
    for (int i = 0; i < n; ++i) {
        bst.insert(sortedArray[i]);
    }
cout<<"��������Ҫɾ����ָ���ؼ���Ԫ��"<<endl;
    
    int c;
    cin>>c;
    bst.remove(c);
bst.printSortedArray();
    // �����۰����ʵ����֪�ؼ��ֵĲ���
    int k;
    cout<<"��������Ҫ���ҵ�ָ���ؼ���Ԫ��"<<endl;
    cin>>k;
    bool found = bst.search(k);

    if (found) {
        cout << "�ؼ��� " << k << " ����������ҵ��ˡ�\n";
    } else {
        cout << "�ؼ��� " << k << " ���������δ�ҵ���\n";
    }
system("pause");
    return 0;
}
