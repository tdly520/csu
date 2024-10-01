import csv
import random
import time
import matplotlib.pyplot as plt
import pandas as pd
# 定义任务类，加入轨道信息和时间约束
class Task:
    def __init__(self, task_id, priority, start_time, end_time, duration, orbit, orbit_length, init_start_time, init_end_time):
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


# 从 CSV 文件读取任务数据并创建任务对象
def read_tasks_from_csv(filename, num_tasks_to_read=None):
    tasks = []
    with open(filename, mode='r') as file:
        reader = csv.DictReader(file)
        for i, row in enumerate(reader):
            if num_tasks_to_read is not None and i >= num_tasks_to_read:
                break  # 读取到指定数量后停止
            task = Task(
                task_id=int(row['Task ID']),
                priority=int(row['Priority']),
                start_time=int(row['Start Time']),
                end_time=int(row['End Time']),
                duration=int(row['Duration']),
                orbit=int(row['Orbit']),
                orbit_length=int(row['Orbit Length']),
                init_start_time=int(row['Init Start Time']),
                init_end_time=int(row['Init End Time'])
            )
            tasks.append(task)
    return tasks

# 轨道状态数组初始化
def initialize_orbit_status(num_orbits):
    return [0] * num_orbits  # 0 表示空闲, 1 表示被占用

# 确保轨道分配约束满足
def apply_orbit_constraints(tasks, orbit_status):
    scheduled_tasks = []

    # 根据优先级排序任务
    tasks = sorted(tasks, key=lambda x: x.priority, reverse=True)

    for task in tasks:
        orbit = task.orbit - 1  # 轨道索引（从0开始）
        if orbit_status[orbit] == 0:  # 如果轨道为空闲
            orbit_status[orbit] = 1  # 标记轨道为占用
            scheduled_tasks.append(task)  # 将任务加入调度
        else:
            # 轨道被占用，选择次高优先级任务
            for other_task in tasks:
                if other_task != task and orbit_status[other_task.orbit - 1] == 0:  # 选择次高优先级轨道空闲的任务
                    orbit_status[other_task.orbit - 1] = 1
                    scheduled_tasks.append(other_task)
                    break

    return scheduled_tasks

# 动态调整任务优先级的调整因子 ∆P(Ti, t)
def adjust_priority(tasks, t):
    for task in tasks:
        delta_p = random.uniform(0, 1)  # 使用随机的调整因子
        task.priority += delta_p  # 动态调整优先级
    return tasks

# 计算目标函数
def calculate_objective(tasks):
    S_numerator = sum(task.priority * task.duration for task in tasks)
    S_denominator = sum((task.end_time - task.start_time) * task.duration for task in tasks)

    C_max = max(task.end_time for task in tasks)
    C_min = min(task.start_time for task in tasks)

    objective_value = S_numerator * (C_max - C_min) - S_numerator * S_denominator
    return objective_value

# 初始化种群
def initialize_population(tasks, population_size):
    population = []
    for _ in range(population_size):
        individual = tasks.copy()
        random.shuffle(individual)  # 随机打乱任务顺序，作为一个个体
        population.append(individual)
    return population

# 计算适应度
def fitness(individual):
    return calculate_objective(individual)

# 选择过程（锦标赛选择）
def selection(population, fitness_scores, tournament_size=3):
    selected = []
    for _ in range(2):
        tournament = random.sample(list(zip(population, fitness_scores)), tournament_size)
        selected.append(max(tournament, key=lambda x: x[1])[0])
    return selected

# 单点交叉
def crossover(parent1, parent2):
    point = random.randint(1, len(parent1) - 1)
    child1 = parent1[:point] + [task for task in parent2 if task not in parent1[:point]]
    child2 = parent2[:point] + [task for task in parent1 if task not in parent2[:point]]
    return child1, child2

# 变异（交换两个任务）
def mutation(individual, mutation_rate=0.1):
    if random.random() < mutation_rate:
        idx1, idx2 = random.sample(range(len(individual)), 2)
        individual[idx1], individual[idx2] = individual[idx2], individual[idx1]

# 遗传算法
def genetic_algorithm(tasks, population_size=50, generations=100, mutation_rate=0.1):
    population = initialize_population(tasks, population_size)

    for generation in range(generations):
        fitness_scores = [fitness(ind) for ind in population]

        new_population = []
        for _ in range(population_size // 2):
            # 选择父代
            parent1, parent2 = selection(population, fitness_scores)
            # 交叉
            child1, child2 = crossover(parent1, parent2)
            # 变异
            mutation(child1, mutation_rate)
            mutation(child2, mutation_rate)
            # 添加到新种群
            new_population.extend([child1, child2])

        population = new_population

    # 返回适应度最高的个体
    fitness_scores = [fitness(ind) for ind in population]
    best_individual = population[fitness_scores.index(max(fitness_scores))]
    return best_individual

def genetic_algorithm_with_timing(tasks, population_size=50, generations=100, mutation_rate=0.1):
    population = initialize_population(tasks, population_size)

    run_times = []  # 用于存储每代的运行时间

    for generation in range(generations):
        start_time = time.time()  # 记录代开始时的时间

        fitness_scores = [fitness(ind) for ind in population]

        new_population = []
        for _ in range(population_size // 2):
            # 选择父代
            parent1, parent2 = selection(population, fitness_scores)
            # 交叉
            child1, child2 = crossover(parent1, parent2)
            # 变异
            mutation(child1, mutation_rate)
            mutation(child2, mutation_rate)
            # 添加到新种群
            new_population.extend([child1, child2])

        population = new_population

        # 计算当前代的运行时间并记录
        run_time = time.time() - start_time
        run_times.append(run_time)

    # 返回适应度最高的个体和运行时间列表
    fitness_scores = [fitness(ind) for ind in population]
    best_individual = population[fitness_scores.index(max(fitness_scores))]
    return best_individual, run_times
def compute_growth_rate(run_times):
    growth_rates = []
    for i in range(1, len(run_times)):
        if run_times[i - 1] == 0:  # 防止除以零
            growth_rate = 0  # 如果前一代运行时间为 0，则设增长率为 0
        else:
            growth_rate = (run_times[i] - run_times[i - 1]) / run_times[i - 1] * 100
        growth_rates.append(growth_rate)
    return growth_rates

# 多次运行并记录时间的函数
def run_multiple_times(tasks, population_size=50, generations=100, mutation_rate=0.1, num_runs=10):
    all_run_times = []  # 用于存储每次运行的时间

    for run in range(num_runs):
        best_schedule, run_times = genetic_algorithm_with_timing(tasks, population_size, generations, mutation_rate)
        all_run_times.append(run_times)

    # 计算每代的平均运行时间
    average_run_times = [sum(times) / len(times) for times in zip(*all_run_times)]

    return average_run_times

# 处理多数据集的函数，返回所有数据集的平均运行时间和增长率
def run_on_multiple_datasets(filenames, num_tasks_list, num_runs=10):
    dataset_avg_times = {}
    dataset_growth_rates = {}

    for filename, num_tasks in zip(filenames, num_tasks_list):
        print(f"\n正在处理数据集 {filename} ({num_tasks} 个任务)...")
        tasks = read_tasks_from_csv(filename, num_tasks_to_read=num_tasks)  # 读取指定数量的任务

        # 执行10次运行并获取平均时间
        average_run_times = run_multiple_times(tasks, population_size=20, generations=50, mutation_rate=0.1, num_runs=num_runs)

        # 计算增长率
        growth_rates = compute_growth_rate(average_run_times)

        dataset_avg_times[num_tasks] = average_run_times
        dataset_growth_rates[num_tasks] = growth_rates
        print(f"数据集 {filename} 的平均运行时间为: {average_run_times}")
        print(f"数据集 {filename} 的增长率为: {growth_rates}")

    return dataset_avg_times, dataset_growth_rates

# 绘制多个数据集的运行时间在同一图上
def plot_multiple_datasets(dataset_avg_times):
    plt.figure(figsize=(10, 6))

    for num_tasks, avg_times in dataset_avg_times.items():
        generations = range(1, len(avg_times) + 1)
        plt.plot(generations, avg_times, marker='o', label=f'{num_tasks} 个任务')

    plt.title("不同任务数量下的平均运行时间")
    plt.xlabel("代数")
    plt.ylabel("平均运行时间（秒）")
    plt.grid(True)
    plt.legend()
    plt.show()

# 绘制增长率表格为图片
def plot_growth_rate_chart(dataset_growth_rates):
    plt.figure(figsize=(10, 6))

    for num_tasks, growth_rates in dataset_growth_rates.items():
        generations = range(2, len(growth_rates) + 2)  # 因为增长率从第2代开始
        plt.plot(generations, growth_rates, marker='o', label=f'{num_tasks} 个任务')

    plt.title("不同任务数量下的运行时间增长率")
    plt.xlabel("代数")
    plt.ylabel("增长率 (%)")
    plt.grid(True)
    plt.legend()
    plt.show()

if __name__ == "__main__":
    # 定义不同数据集文件名和任务数量
    filenames = ["tasks_dataset_50.csv", "tasks_dataset_100.csv", "tasks_dataset_200.csv", "tasks_dataset_500.csv"]
    num_tasks_list = [50, 100, 200, 500]  # 对应任务数量

    # 针对每个数据集运行10次并返回每个数据集的平均运行时间和增长率
    dataset_avg_times, dataset_growth_rates = run_on_multiple_datasets(filenames, num_tasks_list, num_runs=10)

    # 绘制四个数据集的平均运行时间在同一图上
    plot_multiple_datasets(dataset_avg_times)

    # 绘制增长率图表
    plot_growth_rate_chart(dataset_growth_rates)