import cv2
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.pyplot as plt
import matplotlib.font_manager as fm

# 设置字体为 SimHei，支持中文显示
plt.rcParams['font.sans-serif'] = ['SimHei']  # 指定默认字体
plt.rcParams['axes.unicode_minus'] = False  # 解决负号显示问题

from skimage import exposure
from skimage.filters import roberts, sobel, prewitt

# 1. 读取图像并画出灰度直方图
image = cv2.imread('image.png', cv2.IMREAD_GRAYSCALE)

def plot_histogram(img, title):
    plt.figure()
    plt.hist(img.ravel(), bins=256, range=[0, 256])
    plt.title(title)
    plt.xlabel('像素强度')
    plt.ylabel('频率')
    plt.show()

plot_histogram(image, '原始图像的灰度直方图')

# 2 & 3. 进行直方图均衡化并画出均衡化后的直方图
equalized_image = cv2.equalizeHist(image)
plot_histogram(equalized_image, '均衡化后的图像直方图')

# 4. 显示均衡化后的图像
plt.figure()
plt.title("均衡化后的图像")
plt.imshow(equalized_image, cmap='gray')
plt.axis('off')
plt.show()

# 5. （可选）CLAHE 直方图均衡化
clahe = cv2.createCLAHE(clipLimit=2.0, tileGridSize=(8, 8))
clahe_image = clahe.apply(image)
plot_histogram(clahe_image, 'CLAHE 处理后的图像直方图')

plt.figure()
plt.title("CLAHE 处理后的图像")
plt.imshow(clahe_image, cmap='gray')
plt.axis('off')
plt.show()

# 6. 使用3x3的盒状滤波器对均衡化后的图像进行滤波
kernel = np.ones((3, 3), np.float32) / 9
filtered_image = cv2.filter2D(equalized_image, -1, kernel)

plt.figure()
plt.title("使用3x3盒状滤波器后的图像")
plt.imshow(filtered_image, cmap='gray')
plt.axis('off')
plt.show()

# 7. 用Roberts、Sobel、Prewitt算子对均衡化后的图像进行边缘检测
roberts_edges = roberts(equalized_image)
sobel_edges = sobel(equalized_image)
prewitt_edges = prewitt(equalized_image)

# 显示边缘检测结果
fig, axes = plt.subplots(1, 3, figsize=(15, 5))
axes[0].imshow(roberts_edges, cmap='gray')
axes[0].set_title("Roberts 边缘检测")
axes[0].axis('off')

axes[1].imshow(sobel_edges, cmap='gray')
axes[1].set_title("Sobel 边缘检测")
axes[1].axis('off')

axes[2].imshow(prewitt_edges, cmap='gray')
axes[2].set_title("Prewitt 边缘检测")
axes[2].axis('off')

plt.show()
