%% KNN�����㷨
clear,clc;
x1_CSKP=load('fina_CSKP.mat');
FK_CSKP=x1_CSKP.a';
[n1,m1]=size(FK_CSKP);
label_CSKP=ones(n1,1);
%% ��ȡ����
x2_CRKP=load('fina_CRKP.mat');
FK_CRKP=x2_CRKP.a';
[n1,m1]=size(FK_CRKP);
label_CRKP=2*ones(n1,1);
%% �ϲ����ݼ�
x_train=[FK_CSKP;FK_CRKP];
y_label=[label_CSKP;label_CRKP];
%% K-fold crassvalid������֤����
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
	test=(indices==i); %���Ϊ�߼�ֵ��ÿ��ѭ��ѡȡһ������Ϊ���Լ�
	train=~test; %ȡtest�Ĳ�����Ϊѵ����
	TrainData=x_train(train,:); %��ȡѵ�������� 
	TestData=x_train(test,:); %��ȡ���Լ�����
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