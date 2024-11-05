%% ��ȡ����
clc,clear;
x1=load('train_spectra.mat');
x_tr=x1.spectra_train;
x_train=mapstd(x_tr);
y1=load('label_train.mat');
y_label=y1.Label;
%% K-fold crassvalid������֤����
[n,m]=size(x_train);
CVLDA=[];
cell={};
LDA_Avreage=[];
LDA_sigma=[];
for j=1:15
k=10;
indices=crossvalind('KFold',n,k);
%% calculation
for i=1:k
	test=(indices==i); %���Ϊ�߼�ֵ��ÿ��ѭ��ѡȡһ������Ϊ���Լ�
	train=~test; %ȡtest�Ĳ�����Ϊѵ����
	TrainData=x_train(train,:); %��ȡѵ�������� 
	TestData=x_train(test,:); %��ȡ���Լ�����
    Label_train=y_label(train,:);
    Label_test=y_label(test,:);
    %% RF caculation
X=TrainData;
Y= Label_train;
Mdl = fitcdiscr(X,Y);
newX=TestData;
[Y_pre,score] = predict(Mdl,newX);
% save
resum=[Label_test,Y_pre];
cell{j,i}=resum;
%
statis_LDA=CVaccuration( Label_test,Y_pre,2);
CVLDA=[CVLDA;statis_LDA];
end
end
LDA_Avreage=[LDA_Avreage;mean(CVLDA)];
LDA_sigma=[std(CVLDA);LDA_sigma];


