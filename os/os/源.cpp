#include <stdio.h>

#define MAX_PROCESSES 10
#define MAX_MEMORY 1000

// 进程控制块
typedef struct {
    int pid; // 进程ID
    int status; // 进程状态：0表示创建，1表示就绪，2表示运行，3表示阻塞
    int memory_size; // 进程占用的内存大小
} PCB;

PCB processes[MAX_PROCESSES]; // 进程数组
int memory[MAX_MEMORY]; // 内存数组，用于模拟内存空间

// 创建进程
void createProcess(int pid, int memory_size) {
    if (pid < MAX_PROCESSES) {
        processes[pid].pid = pid;
        processes[pid].status = 1; // 就绪状态
        processes[pid].memory_size = memory_size;

        // 在内存中分配空间
        for (int i = 0; i < memory_size; i++) {
            memory[i] = pid;
        }

        printf("Process %d created with memory size %d\n", pid, memory_size);
    }
    else {
        printf("Error: Maximum number of processes reached\n");
    }
}

// 终止进程
void killProcess(int pid) {
    if (pid < MAX_PROCESSES && processes[pid].status != 0) {
        processes[pid].status = 0; // 设置为创建状态
        printf("Process %d terminated\n", pid);

        // 释放内存空间
        for (int i = 0; i < processes[pid].memory_size; i++) {
            memory[i] = -1;
        }
    }
    else {
        printf("Error: Process %d does not exist or is already terminated\n", pid);
    }
}

// 显示所有进程状态
void displayProcesses() {
    printf("Processes:\n");
    for (int i = 0; i < MAX_PROCESSES; i++) {
        if (processes[i].status != 0) {
            printf("PID: %d, Status: %d, Memory Size: %d\n", processes[i].pid, processes[i].status, processes[i].memory_size);
        }
    }
}

// 显示内存空间使用情况
void displayMemory() {
    printf("Memory Usage:\n");
    for (int i = 0; i < MAX_MEMORY; i++) {
        printf("%d ", memory[i]);
    }
    printf("\n");
}

int main() {
    // 初始化内存
    for (int i = 0; i < MAX_MEMORY; i++) {
        memory[i] = -1;
    }

    int choice, pid, memory_size;

    do {
        printf("\n1. Create Process\n2. Kill Process\n3. Display Processes\n4. Display Memory Usage\n5. Exit\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) {
        case 1:
            printf("Enter PID and memory size: ");
            scanf("%d %d", &pid, &memory_size);
            createProcess(pid, memory_size);
            break;
        case 2:
            printf("Enter PID to kill: ");
            scanf("%d", &pid);
            killProcess(pid);
            break;
        case 3:
            displayProcesses();
            break;
        case 4:
            displayMemory();
            break;
        case 5:
            printf("Exiting...\n");
            break;
        default:
            printf("Invalid choice\n");
        }
    } while (choice != 5);

    return 0;
}
