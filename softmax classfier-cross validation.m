%% 提取光谱
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
%% K-fold crassvalid交叉验证计算
[n,m]=size(x_train);
CVSC=[];
cell={};
SC_Avreage=[];
SC_sigma=[];
for j=1:15
k=10;
indices=crossvalind('KFold',n,k);
%% calculation
for i=1:k
	test=(indices==i); %结果为逻辑值，每次循环选取一个组作为测试集
	train=~test; %取test的补集即为训练集
	TrainData=x_train(train,:); %提取训练集数据 
	TestData=x_train(test,:); %提取测试集数据
    Label_train=y_train_label(train,:);
    Label_test=y_train_label(test,:);
    %% RF caculation
trainlabel_out=transfer(Label_train,4);
net = trainSoftmaxLayer(TrainData',trainlabel_out','MaxEpochs',500);
Y_pre1= net(TestData');
output_pre1=math_transfer(Y_pre1);% 将计算结果转化为0和1，即如果Y_re的值小于0.5，则为0
Y_pre=bina_transfer(output_pre1);% 将计算结果转化为1个阵列的多种类
resum=[Label_test,Y_pre];
%cell{j,i}=resum;
statis_SC=CVaccuration( Label_test,Y_pre,4);
CVSC=[CVSC;statis_SC];
end
SC_Avreage=[SC_Avreage;mean(CVSC)];
SC_sigma=[SC_sigma;std(CVSC)];
end
Acurracy_SC=mean(SC_Avreage);
sigma_SC=mean(SC_sigma);
RSD=sigma_SC./Acurracy_SC;