#include <iostream>
#include <vector>
using namespace std;
class TreeNode {
public:
    int key;
    TreeNode* left;
    TreeNode* right;

    TreeNode(int value) : key(value), left(nullptr), right(nullptr) {}
};

TreeNode* insert_bst(TreeNode* root, int key) {
    if (root == nullptr) {
        return new TreeNode(key);
    }

    if (key < root->key) {
        root->left = insert_bst(root->left, key);
    } else {
        root->right = insert_bst(root->right, key);
    }

    return root;
}

void inorder_traversal(TreeNode* root, std::vector<int>& result) {
    if (root) {
        inorder_traversal(root->left, result);
        result.push_back(root->key);
        inorder_traversal(root->right, result);
    }
}

// ºÚµ•≤Â»Î≈≈–Ú
std::vector<int> simple_insertion_sort(const std::vector<int>& arr) {
    TreeNode* root = nullptr;
    for (int key : arr) {
        root = insert_bst(root, key);
    }

    std::vector<int> sorted_list;
    inorder_traversal(root, sorted_list);
    return sorted_list;
}

// √∞≈›≈≈–Ú
void bubble_sort(std::vector<int>& arr) {
    int n = arr.size();
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n - i - 1; ++j) {
            if (arr[j] > arr[j + 1]) {
                std::swap(arr[j], arr[j + 1]);
            }
        }
    }
}

// øÏÀŸ≈≈–Ú
int partition(std::vector<int>& arr, int low, int high) {
    int pivot = arr[high];
    int i = low - 1;

    for (int j = low; j < high; ++j) {
        if (arr[j] <= pivot) {
            i++;
            std::swap(arr[i], arr[j]);
        }
    }

    std::swap(arr[i + 1], arr[high]);
    return i + 1;
}

void quick_sort(std::vector<int>& arr, int low, int high) {
    if (low < high) {
        int pi = partition(arr, low, high);
        quick_sort(arr, low, pi - 1);
        quick_sort(arr, pi + 1, high);
    }
}

// πÈ≤¢≈≈–Ú
void merge(std::vector<int>& arr, int left, int mid, int right) {
    int n1 = mid - left + 1;
    int n2 = right - mid;

    std::vector<int> left_arr(n1);
    std::vector<int> right_arr(n2);

    for (int i = 0; i < n1; ++i) {
        left_arr[i] = arr[left + i];
    }

    for (int j = 0; j < n2; ++j) {
        right_arr[j] = arr[mid + 1 + j];
    }

    int i = 0, j = 0, k = left;

    while (i < n1 && j < n2) {
        if (left_arr[i] <= right_arr[j]) {
            arr[k] = left_arr[i];
            i++;
        } else {
            arr[k] = right_arr[j];
            j++;
        }
        k++;
    }

    while (i < n1) {
        arr[k] = left_arr[i];
        i++;
        k++;
    }

    while (j < n2) {
        arr[k] = right_arr[j];
        j++;
        k++;
    }
}

void merge_sort(std::vector<int>& arr, int left, int right) {
    if (left < right) {
        int mid = left + (right - left) / 2;
        merge_sort(arr, left, mid);
        merge_sort(arr, mid + 1, right);
        merge(arr, left, mid, right);
    }
}

// ∂—≈≈–Ú
void heapify(std::vector<int>& arr, int n, int i) {
    int largest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < n && arr[left] > arr[largest]) {
        largest = left;
    }

    if (right < n && arr[right] > arr[largest]) {
        largest = right;
    }

    if (largest != i) {
        std::swap(arr[i], arr[largest]);
        heapify(arr, n, largest);
    }
}

void heap_sort(std::vector<int>& arr) {
    int n = arr.size();

    for (int i = n / 2 - 1; i >= 0; i--) {
        heapify(arr, n, i);
    }

    for (int i = n - 1; i >= 0; i--) {
        std::swap(arr[0], arr[i]);
        heapify(arr, i, 0);
    }
}

int main() {
    //setlocale(LC_ALL, ""); // …Ë÷√÷–Œƒ ‰≥ˆ

    cout << "«Î ‰»Î‘™Àÿ ˝¡ø£∫";
    int num_elements;
    std::cin >> num_elements;

    std::vector<int> input;
    std::cout << "«Î ‰»Î“‘ø’∏Ò∑÷∏Ùµƒ‘™Àÿ÷µ£∫";
    for (int i = 0; i < num_elements; ++i) {
        int element;
        std::cin >> element;
        input.push_back(element);
    }

    // ºÚµ•≤Â»Î≈≈–Ú
    std::vector<int> simple_insertion_result = simple_insertion_sort(input);
    std::cout << "ºÚµ•≤Â»Î≈≈–Ú£∫";
    for (int num : simple_insertion_result) {
        std::cout << num << " ";
    }
    std::cout << std::endl;

    // √∞≈›≈≈–Ú
    std::vector<int> bubble_result = input;
    bubble_sort(bubble_result);
    std::cout << "√∞≈›≈≈–Ú£∫";
    for (int num : bubble_result) {
        std::cout << num << " ";
    }
    std::cout << std::endl;

    // øÏÀŸ≈≈–Ú
    std::vector<int> quick_result = input;
    quick_sort(quick_result, 0, quick_result.size() - 1);
    std::cout << "øÏÀŸ≈≈–Ú£∫";
    for (int num : quick_result) {
        std::cout << num << " ";
    }
    std::cout << std::endl;

    // πÈ≤¢≈≈–Ú
    std::vector<int> merge_result = input;
    merge_sort(merge_result, 0, merge_result.size() - 1);
    std::cout << "πÈ≤¢≈≈–Ú£∫";
    for (int num : merge_result) {
        std::cout << num << " ";
    }
    std::cout << std::endl;

    // ∂—≈≈–Ú
    std::vector<int> heap_result = input;
    heap_sort(heap_result);
    std::cout << "∂—≈≈–Ú£∫";
    for (int num : heap_result) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
system("pause");
    return 0;
}
