clc,clear;
%% 训练集
x1=load('train_spectra.mat');
x_train=x1.spectra_train;
y1=load('label_train.mat');
y_train_label=y1.Label_train;
%% 测试集
x2=load('test_spectra.mat');
x_test=x2.spectra_test;
y2=load('label_test.mat');
y_test_label=y2.Label;
%% Softmax caculation
%[n,m]=size(x_train);
CVSC=[];
%% 极限学习机
%%  ELM
P_train=x_train';
T_train=y_train_label';
%% test datasets
P_test=x_test';
T_test=y_test_label';
% net
for i=1:15
[IW,B,LW,TF,TYPE] = elmtrain(P_train,T_train,100,'sig',1);
Y_pre = elmpredict(P_test,IW,B,LW,TF,TYPE);
resum=[y_test_label,Y_pre'];
statis_SC=CVaccuration(y_test_label,Y_pre',4);
CVSC=[CVSC;statis_SC];
end
SC_Avreage=mean(CVSC);
SC_sigma=std(CVSC);