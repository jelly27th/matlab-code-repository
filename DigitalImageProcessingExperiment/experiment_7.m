close all;
i = imread('6.jpg'); % 读入原图像
f = rgb2gray(i);
F = fft2(f); % 对图像进行傅立叶变换
% 对变换后图像进行队数变化，并对其坐标平移，使其中心化
S = fftshift(log(1+abs(F)));
spectrum1 = uint8(mat2gray(S)*255);%标准化使范围在[0.255]
figure(1),imshow(spectrum1); % 显示频谱图像
h = fspecial('sobel'); % 产生空间'sobel'模版
figure(2),freqz2(h); % 查看相应频域滤波器的图像
PQ = paddedsize(size(f)); % 产生滤波时所需大小的矩阵
H = freqz2(h,PQ(1),PQ(2)); % 产生频域中的'sobel'滤波器
H1 = ifftshift(H); % 重排数据序列，使得原点位于频率矩阵的左上角
figure(3),imshow(abs(H),[]) % 以图形形式显示滤波器
figure(4),imshow(abs(H1),[])
gs = imfilter(double(f),h); % 用模版 h 进行空域滤波
gf = dftfilt(f,H1); % 用滤波器对图像进行频域滤波
figure(5),imshow(gs,[])
figure(6),imshow(gf,[])
figure(7),imshow(abs(gs),[])
figure(8),imshow(abs(gf),[])
% f = imread('number.tif'); % 读取图片
PQ = paddedsize(size(f)); % 产生滤波时所需大小的矩阵
D0 = 0.05*PQ(1); % 设定高斯高通滤波器的阈值
H = hpfilter1('gaussian',PQ(1),PQ(2),D0); % 产生高斯高通滤波器
g = dftfilt(f,H); % 对图像进行滤波
figure(9),imshow(f) % 显示原图像
figure(10),imshow(g,[]) %显示滤波后图像