%% Reading mat documents and recombine them into one
% 获取当前目录下的所有.txt文件
clc,clear;
fileList = dir('*.mat');
% 遍历每个文件并打开、读取内容或者其他操作
a=[ ];
for i = 1:length(fileList)
    fileName = fileList(i).name; % 获取文件名
    % 载入 mat 数据
    val_struct = load(fileName);% 载入 mat 数据，出来是一个结构体，我们需要的变量是【结构体.变量名】
    val_names = fieldnames(val_struct);  % 获取结构体后那个未知的变量名
    x_data = getfield(val_struct, val_names{1});  % 读取该变量名下的数据，并重新命名变量名val
    %a{i}=x_data(:,2:end);
     a=[a,x_data(:,2:end)];
    % 根x_data据需要对文件进行相应的操作
    %fprintf('正在处理文件：%s\n', fileName);
end
save('TL_one','a');
%plot(avreage(:,1),avreage(:,2))
%x2=mean(fina_jinpu_blank(:,2:end),2);