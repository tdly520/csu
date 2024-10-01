// 内存区域的大小
#define MEMORY_SIZE 1024 // 假设内存大小为1024字节

#define SLICE 5

#include <iostream>
#include <vector>

using namespace std;

// 使用可变分区内存分配算法
// 使用Best Fit算法
// 内存分区结构体
struct Mem_Partition {
    int p_id;
    int start_loc;
    int size;
    bool is_alloc;
};

// 定义可用内存分区的向量
vector<Mem_Partition> free_partitions;

// 分配内存
bool mem_alloc(int p_id, int size) {
    // 遍历空闲分区，寻找第一个能够容纳所需大小的分区
    for (auto& p : free_partitions) {
        if (!p.is_alloc && p.size >= size) {
            // 找到了合适的空闲分区，分配给进程
            p.p_id = p_id;
            p.is_alloc = true;
            cout << "Allocated memory for process " << p_id << " at address " << p.start_loc
                << " with size " << p.size << endl;
            return true;
        }
    }
    // 没有找到合适的空闲分区
    cerr << "Failed to allocate memory for process " << p_id << ": No suitable partition available." << endl;
    return false;
}

// 释放内存
void mem_free(int p_id) {
    // 遍历已分配的分区，释放给定进程的内存
    for (auto& partition : free_partitions) {
        if (partition.p_id == p_id && partition.is_alloc) {
            // 找到了分配给给定进程的分区，释放该分区
            partition.is_alloc = false;
            cout << "Memory for process " << p_id << " has been deallocated." << endl;
            return;
        }
    }
    // 没有找到给定进程的分配分区
    cerr << "Failed to deallocate memory for process " << p_id << ": Process not found." << endl;
}

// 初始化内存分区
// 1, 2, 4, 8..., 512
// 共计1023
void init() {
    // 初始化一个整个内存大小的空闲分区
    int _size = 1;
    while (_size < MEMORY_SIZE) {
        Mem_Partition partition{};
        partition.start_loc = _size - 1;
        partition.size = _size;
        _size = _size * 2;
        free_partitions.push_back(partition);
    }
}

enum ProcessState {
    CREATED,
    READY,
    BLOCK,
    RUN
};

class PCB {
public:
    PCB(int p_id, int m_size, int duration, int io_begin, int io_end)
        : p_id(p_id), m_size(m_size), duration(duration),
        io_begin(io_begin), io_end(io_end) {}

    int p_id = -1;                // 进程ID
    ProcessState p_state = CREATED;    // 进程状态

    int duration;            // 运行完毕所需时间
    int current_time = 0;        // 已运行时间

    int m_size;              // 内存大小

    int io_begin;            // I/O操作起始时间
    int io_end;              // I/O操作结束时间
};

vector<PCB> create_list;      //创建
vector<PCB> ready_list;       //就绪
vector<PCB> running_list;     //运行
vector<PCB> block_list;       //阻塞

void p_create(int p_id, int m_size, int duration, int io_begin, int io_end);           //创建进程
void p_kill(int p_id);           //撤销进程
void p_block(int p_id);            //阻塞进程
void p_awake(int p_id);            //唤醒进程
void p_run();              //运行进程
void p_show();             //显示所有进程状态

void p_create(int p_id, int m_size, int duration, int io_begin = -1, int io_end = -1) {
    PCB p(p_id, m_size, duration, io_begin, io_end);
    if (mem_alloc(p_id, m_size)) {
        create_list.push_back(p);
    }
    else cerr << "Exceeding existing memory" << endl;
    ready_list = create_list;
}

void delete_from_list(vector<PCB>& processList, int p_id) {
    for (auto it = processList.begin(); it != processList.end(); ++it) {
        if (it->p_id == p_id) {
            processList.erase(it);
            return;
        }
    }
}

void update_list(vector<PCB>& processList, ProcessState _s) {
    for (auto& it : processList) {
        it.p_state = _s;
    }
}

void move_to_list(vector<PCB>& p_list1, vector<PCB>& p_list2, int p_id) {
    for (auto it = p_list1.begin(); it != p_list1.end(); ++it) {
        if (it->p_id == p_id) {
            p_list2.push_back(*it);
            p_list1.erase(it);
            break;
        }
    }
}

void p_kill(int p_id) {
    delete_from_list(running_list, p_id);
    delete_from_list(ready_list, p_id);
    delete_from_list(create_list, p_id);
    delete_from_list(block_list, p_id);
    mem_free(p_id);
}

void p_block(int p_id) {
    move_to_list(ready_list, block_list, p_id);
}

void p_awake(int p_id) {
    move_to_list(block_list, ready_list, p_id);
}

void p_update() {
    update_list(create_list, CREATED);
    update_list(ready_list, READY);
    update_list(running_list, RUN);
    update_list(block_list, BLOCK);
}

void p_schedule(int p_id) {
    for (auto& it : ready_list) {
        if (it.p_id == p_id) {
            running_list.push_back(it);
        }
    }
}

void show_list(vector<PCB>& processList) {
    for (auto& it : processList) {
        cout << "ID: " << it.p_id << " Status: ";
        switch (it.p_state) {
        case CREATED: {
            cout << "CREATED";
            break;
        }
        case READY: {
            cout << "READY";
            break;
        }
        case BLOCK: {
            cout << "BLOCK";
            break;
        }
        case RUN: {
            cout << "RUN";
            break;
        }
        }
        cout << " Duration " << it.duration << " Memory " << it.m_size
            << endl;
    }
}

void p_show() {
    p_update();
    show_list(create_list);
    show_list(ready_list);
    show_list(running_list);
    show_list(block_list);
}

void m_show() {
    for (auto& p : free_partitions) {
        cout << "Stat Location: " << p.start_loc << " Size: " << p.size << " Status: ";
        if (p.is_alloc)
            cout << "Is Allocated";
        else cout << "Not Allocated";
        cout << " Process ID: ";
        if (p.p_id > 0)
            cout << p.p_id << endl;
        else cout << "No Process" << endl;
    }
}

void p_run() {
    while (!running_list.empty()) {
        PCB& _p = running_list.front();
        if (_p.current_time <= _p.io_begin && _p.current_time + SLICE >= _p.io_begin) {
            p_block(_p.p_id);
            p_show();
            cout << "Process " << _p.p_id << " I/O between " << _p.io_begin << " and " << _p.io_end << endl;
            p_awake(_p.p_id);
            p_show();
            _p.current_time = _p.io_end;
        }
        else if (_p.duration <= SLICE) {
            cout << "Process " << _p.p_id << " finished" << endl;
            running_list.erase(running_list.begin());
            p_kill(_p.p_id);
        }
        else {
            _p.duration -= SLICE;
            _p.current_time += SLICE;
            cout << "Process " << _p.p_id << " use up one slice" << endl;
            running_list.push_back(_p);
            running_list.erase(running_list.begin());
        }
    }
}


int main() {
    init();
    cout << "create [p_id] [m_size] [duration] [io_begin] [io_end]" << endl;
    cout << "kill [p_id]" << endl;
    cout << "run [p_id]" << endl;
    cout << "schedule [p_id]" << endl;
    cout << "ls" << endl;
    cout << "mem" << endl;
    cout << "exit" << endl;
    while (true) {
        cout << ">> ";
        string command;
        cin >> command;
        switch (command[0]) {
        case 'c': {
            int p_id, m_size, duration, io_begin, io_end;
            cin >> p_id >> m_size >> duration >> io_begin >> io_end;
            p_create(p_id, m_size, duration, io_begin, io_end);
            break;
        }
        case 'k': {
            int p_id;
            cin >> p_id;
            p_kill(p_id);
            break;
        }
        case 'r': {
            int p_id;
            cin >> p_id;
            p_schedule(p_id);
            break;
        }
        case 's': {
            p_run();
            break;
        }
        case 'l': {
            p_show();
            break;
        }
        case 'm': {
            m_show();
            break;
        }
        case 'e': {
            return 0;
        }
        default:
            cout << "Invalid command" << endl;
        }
    }
}
