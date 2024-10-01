#include <iostream>

class ArrayStack {
private:
    static const int MAX = 100;
    int stack[MAX];
    int top;

public:
    ArrayStack() : top(-1) {}

    void push(int value) {
        if (top >= MAX - 1) {
            std::cerr << "����ջ����\n";
            return;
        }

        stack[++top] = value;
    }

    int pop() {
        if (isEmpty()) {
            std::cerr << "����ջΪ��.\n";
            return -1;
        }

        return stack[top--];
    }

    bool isEmpty() const {
        return top == -1;
    }
};

int main() {
    ArrayStack arrayStack;

    int numElements;
    std::cout << "��������� ";
    std::cin >> numElements;

    std::cout << "����Ԫ��\n";
    for (int i = 0; i < numElements; ++i) {
        int element;
        std::cout << "����" << i + 1 << ": ";
        std::cin >> element;
        arrayStack.push(element);
    }

    std::cout << "��ջ\n";
    while (!arrayStack.isEmpty()) {
        std::cout << "Pop: " << arrayStack.pop() << "\n";
    }

    system("pause");
    return 0;
}
