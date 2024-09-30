import tkinter as tk

class Memo:
    def __init__(self, address=0, memory=0):
        self.address = address
        self.memory = memory
        self.allocated = False
        self.process_name = ""

class PCB:
    def __init__(self, arrive_time=0, memory=0, need_time=0, name='', flag=False, me=None):
        self.arrive_time = arrive_time
        self.memory = memory
        self.need_time = need_time
        self.name = name
        self.flag = flag
        self.me = me if me else Memo()

class DiskBlock:
    def __init__(self, start_address=0, size=0):
        self.start_address = start_address
        self.size = size
        self.allocated = False
        self.file_name = ""

class File:
    def __init__(self, file_name, size):
        self.file_name = file_name
        self.size = size
        self.blocks = []

class PcbOperation:
    def __init__(self):
        self.total_memory = 1023
        self.temp = []
        self.pcb_list = []
        self.free_memory_blocks = self.initialize_memory_blocks()
        self.disk_blocks = self.initialize_disk_blocks()
        self.files = []

    def initialize_memory_blocks(self):
        blocks = []
        size = 1
        address = 0
        while size <= 512:
            blocks.append(Memo(address, size))
            address += size
            size *= 2
        return blocks

    def initialize_disk_blocks(self):
        blocks = []
        block_size = 10
        for i in range(100):
            blocks.append(DiskBlock(i * block_size, block_size))
        return blocks

    def readtxt(self):
        processes = [
            ("进程1", 0, 3, 20),
            ("进程2", 2, 2, 50),
            ("进程3", 4, 5, 30),
            ("进程4", 5, 4, 8),
            ("进程5", 5, 1, 14)
        ]
        for name, arrive_time, need_time, memory in processes:
            pcb = PCB(arrive_time, memory, need_time, name)
            if not self.allocate_memory(pcb):
                print(f"内存不足，无法分配给 {pcb.name}")
            self.pcb_list.append(pcb)

    def allocate_memory(self, pcb):
        best_block = None
        for block in self.free_memory_blocks:
            if not block.allocated and block.memory >= pcb.memory:
                if best_block is None or block.memory < best_block.memory:
                    best_block = block

        if best_block is None:
            print("内存不足，无法增加进程")
            return False

        pcb.me.address = best_block.address
        pcb.me.memory = best_block.memory
        best_block.allocated = True
        best_block.process_name = pcb.name

        return True

    def display(self):
        self.window = tk.Tk()
        self.window.title("进程管理系统")

        self.left_frame = tk.Frame(self.window)
        self.left_frame.pack(side=tk.LEFT, padx=10)

        self.middle_frame = tk.Frame(self.window)
        self.middle_frame.pack(side=tk.LEFT, padx=10)

        self.right_frame = tk.Frame(self.window)
        self.right_frame.pack(side=tk.LEFT, padx=10)

        self.refresh_display()

        self.window.mainloop()

    def refresh_display(self, message=None):
        for widget in self.left_frame.winfo_children():
            widget.destroy()
        for widget in self.middle_frame.winfo_children():
            widget.destroy()
        for widget in self.right_frame.winfo_children():
            widget.destroy()

        pcb_label = tk.Label(self.left_frame, text="名称  到达时间  服务时长  所占内存")
        pcb_label.pack()

        for p in self.pcb_list:
            info = f"{p.name}   {p.arrive_time}        {p.need_time}        {p.memory}"
            label = tk.Label(self.left_frame, text=info)
            label.pack()

        block_label = tk.Label(self.left_frame, text="阻塞的进程:")
        block_label.pack()

        self.block_listbox = tk.Listbox(self.left_frame)
        self.block_listbox.pack()

        for p in self.temp:
            self.block_listbox.insert(tk.END, f"{p.name}   {p.arrive_time}        {p.need_time}        {p.memory}")

        mem_label = tk.Label(self.left_frame, text="内存块:")
        mem_label.pack()

        for block in self.free_memory_blocks:
            status = "已分配" if block.allocated else "空闲"
            block_info = f"地址: {block.address}, 大小: {block.memory}, 状态: {status}, 进程: {block.process_name}"
            label = tk.Label(self.left_frame, text=block_info)
            label.pack()

        if message:
            self.message_label = tk.Label(self.middle_frame, text=message)
        else:
            self.message_label = tk.Label(self.middle_frame, text="")

        self.message_label.pack()

        # Process management UI
        self.name_label = tk.Label(self.middle_frame, text="名称:")
        self.name_entry = tk.Entry(self.middle_frame)
        self.arrive_time_label = tk.Label(self.middle_frame, text="到达时间:")
        self.arrive_time_entry = tk.Entry(self.middle_frame)
        self.need_time_label = tk.Label(self.middle_frame, text="服务时长:")
        self.need_time_entry = tk.Entry(self.middle_frame)
        self.memory_label = tk.Label(self.middle_frame, text="所占内存:")
        self.memory_entry = tk.Entry(self.middle_frame)
        self.add_button = tk.Button(self.middle_frame, text="增加进程", command=self.add_process)

        self.block_name_label = tk.Label(self.middle_frame, text="阻塞名称:")
        self.block_name_entry = tk.Entry(self.middle_frame)
        self.block_button = tk.Button(self.middle_frame, text="阻塞进程", command=self.block_process)

        self.wake_name_label = tk.Label(self.middle_frame, text="唤醒名称:")
        self.wake_name_entry = tk.Entry(self.middle_frame)
        self.wake_button = tk.Button(self.middle_frame, text="唤醒进程", command=self.wake_process)

        self.terminate_name_label = tk.Label(self.middle_frame, text="移除名称:")
        self.terminate_name_entry = tk.Entry(self.middle_frame)
        self.terminate_button = tk.Button(self.middle_frame, text="终止进程", command=self.terminate_process)

        self.schedule_button = tk.Button(self.middle_frame, text="调度进程", command=self.schedule_process)

        self.display_memory_button = tk.Button(self.middle_frame, text="显示内存分配",
                                               command=self.display_memory_allocation)

        self.display_disk_button = tk.Button(self.middle_frame, text="显示磁盘分配",
                                             command=self.display_disk_allocation)

        self.name_label.pack()
        self.name_entry.pack()
        self.arrive_time_label.pack()
        self.arrive_time_entry.pack()
        self.need_time_label.pack()
        self.need_time_entry.pack()
        self.memory_label.pack()
        self.memory_entry.pack()
        self.add_button.pack()
        self.block_name_label.pack()
        self.block_name_entry.pack()
        self.block_button.pack()
        self.wake_name_label.pack()
        self.wake_name_entry.pack()
        self.wake_button.pack()
        self.terminate_name_label.pack()
        self.terminate_name_entry.pack()
        self.terminate_button.pack()
        self.schedule_button.pack()
        self.display_memory_button.pack()
        self.display_disk_button.pack()

        # File management UI
        self.create_file_label = tk.Label(self.right_frame, text="文件名:")
        self.create_file_entry = tk.Entry(self.right_frame)
        self.create_file_size_label = tk.Label(self.right_frame, text="文件大小:")
        self.create_file_size_entry = tk.Entry(self.right_frame)
        self.create_file_button = tk.Button(self.right_frame, text="创建文件", command=self.create_file)

        self.delete_file_label = tk.Label(self.right_frame, text="删除文件名:")
        self.delete_file_entry = tk.Entry(self.right_frame)
        self.delete_file_button = tk.Button(self.right_frame, text="删除文件", command=self.delete_file)

        self.create_file_label.pack()
        self.create_file_entry.pack()
        self.create_file_size_label.pack()
        self.create_file_size_entry.pack()
        self.create_file_button.pack()
        self.delete_file_label.pack()
        self.delete_file_entry.pack()
        self.delete_file_button.pack()

    def add_process(self):
        name = self.name_entry.get()
        arrive_time = int(self.arrive_time_entry.get())
        need_time = int(self.need_time_entry.get())
        memory = int(self.memory_entry.get())
        new_pcb = PCB(arrive_time, memory, need_time, name)

        if not self.allocate_memory(new_pcb):
            self.refresh_display("内存不足，无法增加进程")
            return

        for i in range(len(self.pcb_list)):
            if new_pcb.arrive_time < self.pcb_list[i].arrive_time:
                self.pcb_list.insert(i, new_pcb)
                break
        else:
            self.pcb_list.append(new_pcb)

        self.refresh_display("进程增加成功")

    def block_process(self):
        name = self.block_name_entry.get()
        for i, pcb in enumerate(self.pcb_list):
            if pcb.name == name:
                self.free_memory(pcb)
                self.temp.append(self.pcb_list.pop(i))
                self.refresh_display()
                return
        self.refresh_display("输入有误，请重新输入！")

    def wake_process(self):
        name = self.wake_name_entry.get()
        for i, pcb in enumerate(self.temp):
            if pcb.name == name:
                if not self.allocate_memory(pcb):
                    self.refresh_display("内存不足，无法唤醒进程")
                    return
                self.pcb_list.append(self.temp.pop(i))
                self.refresh_display()
                return
        self.refresh_display("输入有误，请重新输入！")

    def terminate_process(self):
        name = self.terminate_name_entry.get()
        for i, pcb in enumerate(self.pcb_list):
            if pcb.name == name:
                self.free_memory(pcb)
                self.pcb_list.pop(i)
                self.refresh_display("进程已终止")
                return
        self.refresh_display("输入有误，请重新输入！")

    def free_memory(self, pcb):
        for block in self.free_memory_blocks:
            if block.address == pcb.me.address and block.memory == pcb.me.memory:
                block.allocated = False
                block.process_name = ""

    def schedule_process(self):
        if not self.pcb_list:
            self.refresh_display("当前没有需要调度的进程")
            return

        time_quantum = 1  # 时间片
        current_time = 0
        while self.pcb_list:
            pcb = self.pcb_list.pop(0)
            output = f"调度进程: {pcb.name}, 剩余服务时间: {pcb.need_time}, 当前时间: {current_time}"
            print(output)
            if pcb.need_time > time_quantum:
                pcb.need_time -= time_quantum
                current_time += time_quantum
                self.pcb_list.append(pcb)
            else:
                current_time += pcb.need_time
                pcb.need_time = 0

            self.refresh_display(output)
            self.window.update()

    def display_memory_allocation(self):
        self.refresh_display()

    def display_disk_allocation(self):
        self.refresh_display()
        allocated_blocks = [block for block in self.disk_blocks if block.allocated]
        if allocated_blocks:
            disk_info = "\n".join(
                [f"起始地址: {block.start_address}, 大小: {block.size}, 文件名: {block.file_name}" for block in
                 allocated_blocks])
        else:
            disk_info = "当前没有文件被分配"
        disk_label = tk.Label(self.right_frame, text=disk_info)
        disk_label.pack()

    def create_file(self):
        file_name = self.create_file_entry.get()
        file_size = int(self.create_file_size_entry.get())
        new_file = File(file_name, file_size)

        required_blocks = (file_size + 9) // 10  # 需要的磁盘块数量

        allocated_blocks = []
        for block in self.disk_blocks:
            if not block.allocated:
                allocated_blocks.append(block)
                if len(allocated_blocks) == required_blocks:
                    break

        if len(allocated_blocks) < required_blocks:
            self.refresh_display("磁盘空间不足，无法创建文件")
            return

        for block in allocated_blocks:
            block.allocated = True
            block.file_name = file_name
            new_file.blocks.append(block)

        self.files.append(new_file)
        self.refresh_display("文件创建成功")

    def delete_file(self):
        file_name = self.delete_file_entry.get()
        file_to_delete = None
        for file in self.files:
            if file.file_name == file_name:
                file_to_delete = file
                break

        if not file_to_delete:
            self.refresh_display("文件不存在")
            return

        for block in file_to_delete.blocks:
            block.allocated = False
            block.file_name = ""

        self.files.remove(file_to_delete)
        self.refresh_display("文件删除成功")

pcb_operation = PcbOperation()
pcb_operation.readtxt()
pcb_operation.display()
