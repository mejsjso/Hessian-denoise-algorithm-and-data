% 正弦图像生成器
% 增大画布尺寸以提高高频率下的平滑度，保存纯图像，并增加显示模块

clear; close all; clc;

% --- 【用户可调参数】 ---
% 1. 图像尺寸 (增大画布尺寸)
M = 1024; % 图像高度 (像素)
N = 1024; % 图像宽度 (像素)

% 2. 条纹属性
frequency_f = 0.3; % 空间频率 (密度) (cycles/pixel)。
angle_theta_deg = -60; % 条纹延伸方向 (角度，单位：度)。

% 3. 图像外观
amplitude_A = 100; % 振幅。
bias_B = 127;      % 偏置 (平均灰度值)。
% ---------------------

% --- 【代码主体：生成图像】 ---

% 1. 创建空间坐标网格
[X, Y] = meshgrid(1:N, 1:M);

% 2. 角度转换 (度 -> 弧度)
theta_rad = deg2rad(angle_theta_deg);

% 3. 定义旋转后的坐标轴 U
U = X .* cos(theta_rad) + Y .* sin(theta_rad);

% 4. 计算正弦图像的灰度值
Z = bias_B + amplitude_A * sin(2 * pi * frequency_f * U);

% 5. 确保灰度值在 [0, 255] 范围内
Z(Z < 0) = 0;
Z(Z > 255) = 255;

% 6. 转换为 uint8 类型以便保存和显示
Image_to_Save = uint8(Z);

% --- 【保存纯图像到指定路径】 ---

% 定义保存路径
save_folder = 'C:\Users\HUAWEI\Desktop\第四部分\分辨率分析测试\原始图像\';
filename = '分辨率分析测试图(f=0.3,-60°).png';
full_save_path = fullfile(save_folder, filename);

% 检查文件夹是否存在，如果不存在则创建
if ~exist(save_folder, 'dir')
    mkdir(save_folder);
    fprintf('创建文件夹: %s\n', save_folder);
end

% 使用 imwrite 直接保存图像矩阵，不引入任何边框
imwrite(Image_to_Save, full_save_path);

fprintf('*** 成功保存纯净正弦图像 ***\n');
fprintf('保存路径: %s\n', full_save_path);

% ----------------------------------------------------
% --- 【新增显示模块】 ---
% ----------------------------------------------------

figure('Name', '生成的正弦条纹图像', 'Position', [50, 50, 800, 750]); 

imshow(Image_to_Save);

title(sprintf('生成的正弦图像 \\theta=%.1f^\\circ, f=%.3f \\n (分辨率：%d x %d)', ...
    angle_theta_deg, frequency_f, M, N), 'FontSize', 14, 'FontWeight', 'bold');

% 可选：如果您需要看到灰度值的完整范围，可以添加 colorbar
% colorbar; 

fprintf('*** 图像已显示在 MATLAB 图窗中 ***\n');