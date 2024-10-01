#include <iostream>
using namespace std;
struct ListNode {
    int data;
    ListNode* next;

    ListNode(int val) : data(val), next(nullptr) {}
};

ListNode* createLinkedList(int arr[], int n) {
    ListNode* dummyHead = new ListNode(0);
    ListNode* cur = dummyHead;

    for (int i = 0; i < n; ++i) {
        cur->next = new ListNode(arr[i]);
        cur = cur->next;
    }

    return dummyHead->next;
}

void sortLinkedList(ListNode* head) {
    if (!head || !head->next) {
        return;
    }

    ListNode* cur = head;
    ListNode* nextNode;
    int temp;

    while (cur) {
        nextNode = cur->next;
        while (nextNode) {
            if (cur->data > nextNode->data) {
                temp = cur->data;
                cur->data = nextNode->data;
                nextNode->data = temp;
            }
            nextNode = nextNode->next;
        }
        cur = cur->next;
    }
}

ListNode* deleteNode(ListNode* head, int x) {
    ListNode* dummyHead = new ListNode(0);
    dummyHead->next = head;

    ListNode* prev = dummyHead;
    ListNode* cur = head;

    while (cur) {
        if (cur->data == x) {
            prev->next = cur->next;
            delete cur;
            break;
        }
        prev = cur;
        cur = cur->next;
    }

    return dummyHead->next;
}

void printLinkedList(ListNode* head) {
    while (head) {
        std::cout << head->data << " ";
        head = head->next;
    }
    std::cout << std::endl;
}

int main() {
    std::cout << "����Ԫ�ظ��� "<<endl;
    
    ;
    int n;
    std::cin >> n;

    int* arr = new int[n];

    std::cout << "����Ԫ��ֵ"<<endl;
    for (int i = 0; i < n; ++i) {
        std::cin >> arr[i];
    }

    ListNode* head = createLinkedList(arr, n);

    std::cout << "ԭʼ���� "<<endl;
    printLinkedList(head);

    sortLinkedList(head);

    std::cout << "���������� ";
    printLinkedList(head);

    std::cout << "����Ҫɾ����ֵ";
    int x;
    std::cin >> x;

    head = deleteNode(head, x);

    std::cout << "ɾ��ֵΪ " << x << " �Ľ�������� ";
    printLinkedList(head);

    delete[] arr;
system("pause");
    return 0;
}
