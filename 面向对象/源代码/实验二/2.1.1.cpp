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
            std::cerr << "����ջ�ǿյ�\n";
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
    std::cout << "��������� ";
    std::cin >> numElements;

    std::cout << "��������:\n";
    for (int i = 0; i < numElements; ++i) {
        int element;
        std::cin >> element;
        linkedStack.push(element);
    }

    std::cout << "��ջԪ��\n";
    while (!linkedStack.isEmpty()) {
        std::cout << linkedStack.pop() << "\n";
    }

    system("pause");
    return 0;
}
