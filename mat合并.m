%% Reading mat documents and recombine them into one
% ��ȡ��ǰĿ¼�µ�����.txt�ļ�
clc,clear;
fileList = dir('*.mat');
% ����ÿ���ļ����򿪡���ȡ���ݻ�����������
a=[ ];
for i = 1:length(fileList)
    fileName = fileList(i).name; % ��ȡ�ļ���
    % ���� mat ����
    val_struct = load(fileName);% ���� mat ���ݣ�������һ���ṹ�壬������Ҫ�ı����ǡ��ṹ��.��������
    val_names = fieldnames(val_struct);  % ��ȡ�ṹ����Ǹ�δ֪�ı�����
    x_data = getfield(val_struct, val_names{1});  % ��ȡ�ñ������µ����ݣ�����������������val
    %a{i}=x_data(:,2:end);
     a=[a,x_data(:,2:end)];
    % ��x_data����Ҫ���ļ�������Ӧ�Ĳ���
    %fprintf('���ڴ����ļ���%s\n', fileName);
end
save('TL_one','a');
%plot(avreage(:,1),avreage(:,2))
%x2=mean(fina_jinpu_blank(:,2:end),2);