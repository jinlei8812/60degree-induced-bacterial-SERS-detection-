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
%% BP-ANN
net = feedforwardnet(10);
net = train(net,x_train',y_train_label');
%% RBF-ANN
CVSC=[];
for i=1:15
net=newrb(x_train',y_train_label');
Y_pre=sim(net,x_test');
resum=[y_test_label,Y_pre'];
statis_SC=CVaccuration( y_test_label,Y_pre',4);
CVSC=[CVSC;statis_SC];
end
SC_Avreage=mean(CVSC);
SC_sigma=std(CVSC);
%% GRNN
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
[n,m]=size(x_train);
CVSC=[];
SC_Avreage=[];
SC_sigma=[];
%% calculation
for i=1:15
	TrainData=x_train; %提取训练集数据 
	TestData=x_test; %提取测试集数据
    Label_train=y_train_label;
    Label_test=y_test_label;
net=newgrnn(TrainData', Label_train');
Y_pre=sim(net,TestData');
resum=[Label_test,Y_pre'];
statis_SC=CVaccuration(Label_test,Y_pre',4);
CVSC=[CVSC;statis_SC];
end
SC_Avreage=mean(CVSC);
SC_sigma=std(CVSC);