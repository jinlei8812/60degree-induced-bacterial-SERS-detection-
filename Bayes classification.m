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

%% 贝叶斯分类
CVSC=[];
%SC_Avreage=[];
%SC_sigma=[];
for i=1:15
	TrainData=x_train; %提取训练集数据 
	TestData=x_test; %提取测试集数据
    Label_train=y_train_label;
    Label_test=y_test_label;
    %% training
md1=fitcnb(TrainData,Label_train);
Y_pre=predict(md1,TestData);
resum=[ Label_test,Y_pre];
%cell{j,i}=resum;
statis_SC=CVaccuration(Label_test,Y_pre,4);
CVSC=[CVSC;statis_SC];
end
SC_Avreage=mean(CVSC);
SC_sigma=std(CVSC);