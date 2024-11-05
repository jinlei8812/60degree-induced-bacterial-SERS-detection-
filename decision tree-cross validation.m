%% 提取光谱
clear,clc;
% 提取大肠光谱
x1_mssa=load('fina_MSSA.mat');
JP_MSSA=x1_mssa.a';
[n1,m1]=size(JP_MSSA);
label_MSSA=ones(n1,1);
%% 提取金浦
x2_mrsa=load('fina_MRSA.mat');
JP_MRSA=x2_mrsa.a';
[n2,m2]=size(JP_MRSA);
label_MRSA=2*ones(n2,1);
%% 合并数据集
x_train=[JP_MSSA;JP_MRSA];
y_label=[label_MSSA;label_MRSA];
[n,m]=size(x_train);
%% K-fold crassvalid交叉验证计算
[n,m]=size(x_train);
CVDT=[];
DT_Avreage=[];
DT_sigma=[];
%% CV
k=10;
indices=crossvalind('KFold',n,k);
%% calculation
for i=1:15
for i=1:k
	test=(indices==i); %结果为逻辑值，每次循环选取一个组作为测试集
	train=~test; %取test的补集即为训练集
	TrainData=x_train(train,:); %提取训练集数据 
	TestData=x_train(test,:); %提取测试集数据
    Label_train=y_label(train,:);
    Label_test=y_label(test,:);
    %% RF caculation
net=fitctree(TrainData,Label_train);
Y_pre=predict(net,TestData);
resum=[Label_test,Y_pre];
statis_DT=CVaccuration( Label_test,Y_pre,2);
CVDT=[CVDT;statis_DT];
end
end
DT_Avreage=[DT_Avreage;mean(CVDT)];
DT_sigma=[std(CVDT);DT_sigma];
