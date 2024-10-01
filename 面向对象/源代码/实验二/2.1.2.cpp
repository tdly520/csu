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
            std::cerr << "´íÎó£¬Õ»ÂúÁË\n";
            return;
        }

        stack[++top] = value;
    }

    int pop() {
        if (isEmpty()) {
            std::cerr << "´íÎó£¬Õ»Îª¿Õ.\n";
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
    std::cout << "ÇëÊäÈë¸öÊý ";
    std::cin >> numElements;

    std::cout << "ÊäÈëÔªËØ\n";
    for (int i = 0; i < numElements; ++i) {
        int element;
        std::cout << "ÊäÈë" << i + 1 << ": ";
        std::cin >> element;
        arrayStack.push(element);
    }

    std::cout << "³öÕ»\n";
    while (!arrayStack.isEmpty()) {
        std::cout << "Pop: " << arrayStack.pop() << "\n";
    }

    system("pause");
    return 0;
}
