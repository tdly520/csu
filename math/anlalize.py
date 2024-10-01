import random

population_size = 20
num = 50
crossover_rate = 0.8
mutation_rate = 0.1

# (任务编号, 优先级, 开始时间, 结束时间, 持续时间)
tasks = [
    (1, 10, 0, 5, 3),
    (2, 8, 2, 6, 2),
    (3, 7, 1, 7, 4),
    (4, 6, 3, 9, 5),
    (5, 9, 0, 8, 4)
]


def fitness(schedule, tasks):
    S_num=0
    S_den=0
    C_max=0
    C_min=999
    for idx in schedule:
        task = tasks[idx]

        if task[3] >C_max:
            C_max = task[3]
        if task[2] <C_min:
            C_min = task[2]


    for idx in schedule:
        task = tasks[idx]
        pi, si, ei, ti = task[1], task[2], task[3], task[4]
        S_num += pi * ti
        S_den += (ei - si) * ti
    return S_num * (C_max-C_min) - S_den *S_num


def generate(tasks, size):
    return [random.sample(range(len(tasks)), len(tasks)) for _ in range(size)]


def Selection(population, fitness_values):
    selected = []
    for _ in range(len(population)):
        i, j = random.sample(range(len(population)), 2)
        if fitness_values[i] > fitness_values[j]:
            selected.append(population[i])
        else:
            selected.append(population[j])
    return selected


def crossover(parent1, parent2):
    if random.random() < crossover_rate:
        point1, point2 = sorted(random.sample(range(len(parent1)), 2))
        child1 = [-1] * len(parent1)
        child2 = [-1] * len(parent2)


        child1[point1:point2] = parent1[point1:point2]
        child2[point1:point2] = parent2[point1:point2]


        def fill_child(child, parent, other_parent):
            pos = (point2 % len(parent))
            for i in range(len(parent)):
                if parent[i] not in child:
                    while child[pos] != -1:
                        pos = (pos + 1) % len(child)
                    child[pos] = parent[i]
                pos = (pos + 1) % len(child)

        fill_child(child1, parent2, parent1)
        fill_child(child2, parent1, parent2)

        return child1, child2
    return parent1, parent2

def mutate(schedule):
    if random.random() < mutation_rate:
        i, j = random.sample(range(len(schedule)), 2)
        schedule[i], schedule[j] = schedule[j], schedule[i]
    return schedule


def genetic_algorithm(tasks):
    population = generate(tasks, population_size)
    for generation in range(num):
        fitness_values = [fitness(individual, tasks) for individual in population]
        next_population = Selection(population, fitness_values)

        new_population = []
        for i in range(0, population_size, 2):
            parent1, parent2 = next_population[i], next_population[i+1]
            child1, child2 = crossover(parent1, parent2)
            new_population.append(mutate(child1))
            new_population.append(mutate(child2))

        population = new_population


    fitness_values = [fitness(individual, tasks) for individual in population]
    best_fitness = max(fitness_values)
    best_schedule = population[fitness_values.index(best_fitness)]

    return best_schedule, best_fitness


def print_schedule(schedule, tasks):
    print("最优任务调度顺序: ")
    for idx in schedule:
        task = tasks[idx]
        print(f"任务 {task[0]} - 优先级: {task[1]}, 开始时间: {task[2]}, 结束时间: {task[3]}, 持续时间: {task[4]}")
    print(f"最优适应度值: {best_fitness}")


best_schedule, best_fitness = genetic_algorithm(tasks)
print_schedule(best_schedule, tasks)
