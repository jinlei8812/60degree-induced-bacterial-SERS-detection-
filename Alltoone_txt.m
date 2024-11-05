%Reconsctruct all txt into one
% 获取当前目录下的所有.txt文件
clc,clear;
fileList = dir('*.txt');
% 遍历每个文件并打开、读取内容或者其他操作
a=[];
for i = 1:length(fileList)
    fileName = fileList(i).name; % 获取文件名
    x_data=load(fileName);
    a=[a,x_data(:,2)];
    % 根据需要对文件进行相应的操作
    %fprintf('正在处理文件：%s\n', fileName);
end
fina_7min=[x_data(:,1),a];
avreage7min=[x_data(:,1),mean(a,2)];
savename = 'fina_7min_2.txt';
dlmwrite(savename, avreage7min);
%save('fina_DC_1h.mat','fina_DC_1h');
%plot(avreage_DC_1h(:,1),avreage_DC_1h(:,2))
%x2=mean(fina_jinpu_blank(:,2:end),2);