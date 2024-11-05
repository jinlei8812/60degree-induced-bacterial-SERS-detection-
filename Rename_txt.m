%% Rename txt
clc,clear;
files=dir(['C:\Users\thinkpad\Desktop\2024国基\超声裂解\大肠\*.txt']);
path1='C:\Users\thinkpad\Desktop\2024国基\超声裂解\大肠\';
path2='C:\Users\thinkpad\Desktop\2024国基\超声裂解\大肠\txtdata\';
len=length(files);
for i=1:len
    oldname=files(i).name;
    old_path=[path1,oldname];
    im=load(old_path);
    new_path=sprintf('%s%d.txt',path2,i);
    writematrix(im,new_path);
end

