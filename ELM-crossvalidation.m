%% 提取光谱
clear,clc;
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
%% K-fold crassvalid交叉验证计算
[n,m]=size(x_train);
CVELM=[];
cell={};
ELM_Avreage=[];
ELM_sigma=[];
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
   P_train=TrainData';
    T_train= Label_train';
    P_test=TestData';
    T_test=Label_test';
% net
   [IW,B,LW,TF,TYPE] = elmtrain(P_train,T_train,100,'sig',1);
   Y_pre = elmpredict(P_test,IW,B,LW,TF,TYPE);
resum=[Label_test,Y_pre'];
%cell{j,i}=resum;
statis_RF=CVaccuration( Label_test,Y_pre',2);
CVELM=[CVELM;statis_RF];
end
end
ELM_Avreage=mean(CVELM);
ELM_sigma=std(CVELM);
