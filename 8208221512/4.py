import cv2
import numpy as np
import matplotlib.pyplot as plt

# 加载图像
image_path = 'D:/PycharmProjects/DIP/py/4.png'  
original_image = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)

# 添加高斯噪声
def add_gaussian_noise(image, mean=0, std=25):
    gauss = np.random.normal(mean, std, image.shape).astype(np.float32)
    noisy_image = cv2.add(image.astype(np.float32), gauss)
    noisy_image = np.clip(noisy_image, 0, 255).astype(np.uint8)
    return noisy_image

# 算术均值滤波
def arithmetic_mean_filter(image, kernel_size=3):
    return cv2.blur(image, (kernel_size, kernel_size))

# 几何均值滤波
def geometric_mean_filter(image, kernel_size=3):
    padded_image = np.pad(image, kernel_size // 2, mode='reflect')
    result = np.zeros_like(image, dtype=np.float32)
    for i in range(image.shape[0]):
        for j in range(image.shape[1]):
            region = padded_image[i:i+kernel_size, j:j+kernel_size]
            # 计算几何均值
            result[i, j] = np.exp(np.mean(np.log(region + 1e-10)))  # 避免log(0)
    return np.clip(result, 0, 255).astype(np.uint8)

# 自适应均值滤波
def adaptive_mean_filter(image, kernel_size=3):
    return cv2.bilateralFilter(image, kernel_size, 75, 75)  # 使用双边滤波替代

# 应用滤波操作
noisy_image = add_gaussian_noise(original_image)
arithmetic_filtered = arithmetic_mean_filter(noisy_image)
geometric_filtered = geometric_mean_filter(noisy_image)
adaptive_filtered = adaptive_mean_filter(noisy_image)

# 分开显示和保存结果
def show_and_save(image, title, filename):
    plt.figure(figsize=(8, 6))
    plt.imshow(image, cmap='gray')
    plt.title(title)
    plt.axis('off')
    plt.tight_layout()
    plt.savefig(filename)
    plt.show()

# 原始图像
show_and_save(original_image, "Original Image", "original_image.png")

# 噪声图像
show_and_save(noisy_image, "Noisy Image (Gaussian Noise)", "noisy_image.png")

# 算术均值滤波
show_and_save(arithmetic_filtered, "Arithmetic Mean Filter", "arithmetic_filtered.png")

# 几何均值滤波
show_and_save(geometric_filtered, "Geometric Mean Filter", "geometric_filtered.png")

# 自适应均值滤波
show_and_save(adaptive_filtered, "Adaptive Mean Filter", "adaptive_filtered.png")
