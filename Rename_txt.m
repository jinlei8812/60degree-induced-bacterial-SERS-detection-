%% Rename txt
clc,clear;
files=dir(['C:\Users\thinkpad\Desktop\2024����\�����ѽ�\��\*.txt']);
path1='C:\Users\thinkpad\Desktop\2024����\�����ѽ�\��\';
path2='C:\Users\thinkpad\Desktop\2024����\�����ѽ�\��\txtdata\';
len=length(files);
for i=1:len
    oldname=files(i).name;
    old_path=[path1,oldname];
    im=load(old_path);
    new_path=sprintf('%s%d.txt',path2,i);
    writematrix(im,new_path);
end

