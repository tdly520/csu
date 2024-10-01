#include <iostream>
#include <vector>
#include <queue>

// Definition for a binary tree node.
struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(NULL), right(NULL) {}
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    TreeNode* removeLeafNodes(TreeNode* root, int target) {
        if (!root) {
            return NULL;
        }
        root->left = removeLeafNodes(root->left, target);
        root->right = removeLeafNodes(root->right, target);
        if (root->val == target && !root->left && !root->right) {
            return NULL;
        }
        return root;
    }
};

// Helper function to print the tree (in-order traversal)
void printTree(TreeNode* root) {
    if (!root) return;
    printTree(root->left);
    std::cout << root->val << " ";
    printTree(root->right);
}

// Helper function to build a tree from a level-order list
TreeNode* buildTree(const std::vector<int>& nodes) {
    if (nodes.empty() || nodes[0] == -1) {
        return NULL;
    }

    TreeNode* root = new TreeNode(nodes[0]);
    std::queue<TreeNode*> q;
    q.push(root);
    int i = 1;
    
    while (!q.empty() && i < nodes.size()) {
        TreeNode* curr = q.front();
        q.pop();
        
        if (nodes[i] != -1) {
            curr->left = new TreeNode(nodes[i]);
            q.push(curr->left);
        }
        i++;
        
        if (i < nodes.size() && nodes[i] != -1) {
            curr->right = new TreeNode(nodes[i]);
            q.push(curr->right);
        }
        i++;
    }

    return root;
}

int main() {
    Solution sol;
    
    // Manually input the tree and target
    std::vector<int> nodes;
    nodes.push_back(1);
    nodes.push_back(2);
    nodes.push_back(3);
    nodes.push_back(2);
    nodes.push_back(-1);
    nodes.push_back(2);
    nodes.push_back(4);
    int target = 2;
    
    TreeNode* root = buildTree(nodes);
    TreeNode* result = sol.removeLeafNodes(root, target);
    
    std::cout << "Output: ";
    printTree(result);
    std::cout << std::endl;

    return 0;
}

