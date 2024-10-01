#include <stdio.h>

#define MAX_PROCESSES 10
#define MAX_MEMORY 1000

// ���̿��ƿ�
typedef struct {
    int pid; // ����ID
    int status; // ����״̬��0��ʾ������1��ʾ������2��ʾ���У�3��ʾ����
    int memory_size; // ����ռ�õ��ڴ��С
} PCB;

PCB processes[MAX_PROCESSES]; // ��������
int memory[MAX_MEMORY]; // �ڴ����飬����ģ���ڴ�ռ�

// ��������
void createProcess(int pid, int memory_size) {
    if (pid < MAX_PROCESSES) {
        processes[pid].pid = pid;
        processes[pid].status = 1; // ����״̬
        processes[pid].memory_size = memory_size;

        // ���ڴ��з���ռ�
        for (int i = 0; i < memory_size; i++) {
            memory[i] = pid;
        }

        printf("Process %d created with memory size %d\n", pid, memory_size);
    }
    else {
        printf("Error: Maximum number of processes reached\n");
    }
}

// ��ֹ����
void killProcess(int pid) {
    if (pid < MAX_PROCESSES && processes[pid].status != 0) {
        processes[pid].status = 0; // ����Ϊ����״̬
        printf("Process %d terminated\n", pid);

        // �ͷ��ڴ�ռ�
        for (int i = 0; i < processes[pid].memory_size; i++) {
            memory[i] = -1;
        }
    }
    else {
        printf("Error: Process %d does not exist or is already terminated\n", pid);
    }
}

// ��ʾ���н���״̬
void displayProcesses() {
    printf("Processes:\n");
    for (int i = 0; i < MAX_PROCESSES; i++) {
        if (processes[i].status != 0) {
            printf("PID: %d, Status: %d, Memory Size: %d\n", processes[i].pid, processes[i].status, processes[i].memory_size);
        }
    }
}

// ��ʾ�ڴ�ռ�ʹ�����
void displayMemory() {
    printf("Memory Usage:\n");
    for (int i = 0; i < MAX_MEMORY; i++) {
        printf("%d ", memory[i]);
    }
    printf("\n");
}

int main() {
    // ��ʼ���ڴ�
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
