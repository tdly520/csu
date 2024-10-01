#include <iostream>

struct Node {
    int data;
    Node* next;

    Node(int value) : data(value), next(nullptr) {}
};

class LinkedStack {
private:
    Node* top;

public:
    LinkedStack() : top(nullptr) {}

    void push(int value) {
        Node* newNode = new Node(value);
        newNode->next = top;
        top = newNode;
    }

    int pop() {
        if (isEmpty()) {
            std::cerr << "错误，栈是空的\n";
            return -1;  
        }

        int value = top->data;
        Node* temp = top;
        top = top->next;
        delete temp;

        return value;
    }

    bool isEmpty() const {
        return top == nullptr;
    }
};

int main() {
    LinkedStack linkedStack;

    int numElements;
    std::cout << "请输入个数 ";
    std::cin >> numElements;

    std::cout << "依次输入:\n";
    for (int i = 0; i < numElements; ++i) {
        int element;
        std::cin >> element;
        linkedStack.push(element);
    }

    std::cout << "出栈元素\n";
    while (!linkedStack.isEmpty()) {
        std::cout << linkedStack.pop() << "\n";
    }

    system("pause");
    return 0;
}
