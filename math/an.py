import csv
import random
import time
import matplotlib.pyplot as plt

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
# 从 CSV 文件读取任务数据并创建任务对象
def read_tasks_from_csv(filename, num_tasks_to_read=None):
    tasks = []
    with open(filename, mode='r') as file:
        reader = csv.DictReader(file)
        # 打印表头
        headers = reader.fieldnames

        for i, row in enumerate(reader):
            if num_tasks_to_read is not None and i >= num_tasks_to_read:
                break  # 读取到指定数量后停止


            # 创建任务对象并添加到任务列表
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
def adjust_priority(tasks, t, current_time):

    for task in tasks:
        # 使用轨道长度反比调整优先级，轨道越短，优先级越高
        orbit_factor = 1 / task.orbit_length

        # 计算任务的时间紧迫性，任务的开始时间越接近当前时间，优先级越高
        time_factor = 1 / max(1, abs(task.start_time - current_time))

        # 结合随机因子、轨道长度因子和时间紧迫性因子调整优先级
        delta_p = random.uniform(0, 1) * orbit_factor * time_factor
        task.priority += delta_p  # 动态调整优先级

    return tasks

def calculate_total_execution_time(tasks):
    """
    计算任务调度的总执行时间。
    """
    # 遍历所有任务，找到最晚的结束时间
    max_end_time = max(task.end_time for task in tasks)
    min_start_time = min(task.start_time for task in tasks)

    total_execution_time = max_end_time - min_start_time
    return total_execution_time


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



    # 返回适应度最高的个体和运行时间列表
    fitness_scores = [fitness(ind) for ind in population]
    best_individual = population[fitness_scores.index(max(fitness_scores))]
    return best_individual

def print_task_as_csv(tasks, headers):
    """按照CSV格式输出任务数据"""
    print(",".join(headers))  # 打印表头
    for task in tasks:
        print(f"{task.task_id},{task.priority},{task.start_time},{task.end_time},{task.duration},{task.orbit},{task.orbit_length},{task.init_start_time},{task.init_end_time}")
def save_tasks_to_csv(tasks, filename, headers):
    with open(filename, mode='w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(headers)  # 写入表头
        for task in tasks:
            writer.writerow([task.task_id, task.priority, task.start_time, task.end_time, task.duration, task.orbit, task.orbit_length, task.init_start_time, task.init_end_time])

if __name__ == "__main__":
    num_tasks_to_read = 50 # 自定义读取任务数量，例如读取 50,100,200,500 个任务
    tasks = read_tasks_from_csv("tasks_dataset_500.csv", num_tasks_to_read)  # 从 CSV 文件读取指定数量的任务

    # 设置CSV文件的列标题
    headers = ['Task ID', 'Priority', 'Start Time', 'End Time', 'Duration', 'Orbit', 'Orbit Length', 'Init Start Time', 'Init End Time']

    # 输出初始任务信息（按CSV格式）
    print(f"初始任务数据（共读取 {len(tasks)} 个任务）:")
    print_task_as_csv(tasks[:50], headers)  # 仅显示前10个任务
    print(f"...共读取 {len(tasks)} 个任务\n")

    # 使用遗传算法优化任务调度
    best_schedule = genetic_algorithm(tasks, population_size=20, generations=50, mutation_rate=0.1)

    # 输出优化后的任务信息（按CSV格式）
    print("\n遗传算法优化后的任务数据:")
    print_task_as_csv(best_schedule[:50], headers)  # 仅显示前10个任务
    print(f"...共优化 {len(best_schedule)} 个任务\n")
    # 计算总任务执行时间
    total_execution_time = calculate_total_execution_time(best_schedule)
    print(f"总任务执行时间: {total_execution_time} 单位时间")

    # 计算并输出目标函数的值
    objective_value = calculate_objective(best_schedule)
    print(f"优化后目标函数值: {objective_value}")
