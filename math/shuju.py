import random
import csv


# 定义任务类，加入轨道信息和时间约束
class Task:
    def __init__(self, task_id, priority, start_time, end_time, duration, orbit, orbit_length, init_start_time,
                 init_end_time):
        self.task_id = task_id  # 任务ID
        self.priority = priority  # 任务优先级
        self.start_time = start_time  # 开始时间
        self.end_time = end_time  # 结束时间
        self.duration = duration  # 任务持续时间
        self.orbit = orbit  # 轨道号
        self.orbit_length = orbit_length  # 轨道长度
        self.init_start_time = init_start_time  # 初始最早开始时间
        self.init_end_time = init_end_time  # 初始最晚结束时间

    # 任务信息打印
    def __repr__(self):
        return f"任务{self.task_id} (轨道: {self.orbit}, 优先级: {self.priority}, 持续时间: {self.duration}, 轨道长度: {self.orbit_length})"

    # 获取任务信息作为列表形式，便于保存为CSV
    def to_list(self):
        return [self.task_id, self.priority, self.start_time, self.end_time, self.duration, self.orbit,
                self.orbit_length, self.init_start_time, self.init_end_time]


# 随机生成任务数据，包括时间约束
def generate_tasks(num_tasks, num_orbits):
    tasks = []
    for i in range(num_tasks):
        priority = random.randint(1, 10)  # 优先级范围 1-10
        init_start_time = random.randint(1, 100)  # 最早开始时间

        # 确保 init_end_time 大于 init_start_time + 1
        min_init_end_time = init_start_time + 1
        max_init_end_time = 120
        if min_init_end_time > max_init_end_time:
            min_init_end_time = max_init_end_time  # 防止 min_init_end_time 超过 max
        init_end_time = random.randint(min_init_end_time, max_init_end_time)

        # 计算最大可能的 duration
        max_duration = init_end_time - init_start_time
        if max_duration < 1:
            max_duration = 1  # 至少持续1个单位时间

        # 设定 duration 的上限为 min(20, max_duration)
        duration = random.randint(1, min(20, max_duration))

        # 计算实际的开始时间和结束时间
        start_time = random.randint(init_start_time, init_end_time - duration)
        end_time = start_time + duration

        orbit = random.randint(1, num_orbits)  # 轨道号
        orbit_length = random.randint(10, 20)  # 轨道长度范围

        tasks.append(
            Task(i, priority, start_time, end_time, duration, orbit, orbit_length, init_start_time, init_end_time))
    return tasks

# 将任务列表保存为CSV文件
def save_tasks_to_csv(tasks, filename="tasks.csv"):
    # 指定CSV文件的列名
    fieldnames = ["Task ID", "Priority", "Start Time", "End Time", "Duration", "Orbit", "Orbit Length",
                  "Init Start Time", "Init End Time"]

    # 创建CSV文件并写入数据
    with open(filename, mode='w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(fieldnames)  # 写入列名
        for task in tasks:
            writer.writerow(task.to_list())  # 写入每个任务的数据


# 示例：生成任务并保存为CSV文件
if __name__ == "__main__":
    num_tasks = 500  # 定义任务数量
    num_orbits = 50  # 定义轨道数量
    tasks = generate_tasks(num_tasks, num_orbits)

    # 保存任务列表到本地CSV文件
    save_tasks_to_csv(tasks, "tasks_dataset.csv")
    print("任务数据已保存到 tasks_dataset.csv 文件中。")
