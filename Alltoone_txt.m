%Reconsctruct all txt into one
% ��ȡ��ǰĿ¼�µ�����.txt�ļ�
clc,clear;
fileList = dir('*.txt');
% ����ÿ���ļ����򿪡���ȡ���ݻ�����������
a=[];
for i = 1:length(fileList)
    fileName = fileList(i).name; % ��ȡ�ļ���
    x_data=load(fileName);
    a=[a,x_data(:,2)];
    % ������Ҫ���ļ�������Ӧ�Ĳ���
    %fprintf('���ڴ����ļ���%s\n', fileName);
end
fina_7min=[x_data(:,1),a];
avreage7min=[x_data(:,1),mean(a,2)];
savename = 'fina_7min_2.txt';
dlmwrite(savename, avreage7min);
%save('fina_DC_1h.mat','fina_DC_1h');
%plot(avreage_DC_1h(:,1),avreage_DC_1h(:,2))
%x2=mean(fina_jinpu_blank(:,2:end),2);