%% KNN分类算法
clear,clc;
x1_CSKP=load('fina_CSKP.mat');
FK_CSKP=x1_CSKP.a';
[n1,m1]=size(FK_CSKP);
label_CSKP=ones(n1,1);
%% 提取金浦
x2_CRKP=load('fina_CRKP.mat');
FK_CRKP=x2_CRKP.a';
[n1,m1]=size(FK_CRKP);
label_CRKP=2*ones(n1,1);
%% 合并数据集
x_train=[FK_CSKP;FK_CRKP];
y_label=[label_CSKP;label_CRKP];
%% K-fold crassvalid交叉验证计算
%x_train=wave_train;
[n,m]=size(x_train);
CVKNN=[];
KNN_Avreage=[];
KNN_sigma=[];
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
    %% training 
Mdl = fitcknn(TrainData,Label_train);
[Y_pre,~] = predict(Mdl,TestData);
resum=[Label_test,Y_pre];
%cell{j,i}=resum;
statis_KNN=CVaccuration(Label_test,Y_pre,2);
CVKNN=[CVKNN;statis_KNN];
end
end
KNN_Avreage=mean(CVKNN);
KNN_sigma=std(CVKNN);