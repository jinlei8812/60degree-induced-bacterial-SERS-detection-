%% ��ȡ����
clear,clc;
x1_mssa=load('fina_MSSA.mat');
JP_MSSA=x1_mssa.a';
[n1,m1]=size(JP_MSSA);
label_MSSA=ones(n1,1);
%% ��ȡ����
x2_mrsa=load('fina_MRSA.mat');
JP_MRSA=x2_mrsa.a';
[n2,m2]=size(JP_MRSA);
label_MRSA=2*ones(n2,1);
%% �ϲ����ݼ�
x_train=[JP_MSSA;JP_MRSA];
y_label=[label_MSSA;label_MRSA];
%% K-fold crassvalid������֤����
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
	test=(indices==i); %���Ϊ�߼�ֵ��ÿ��ѭ��ѡȡһ������Ϊ���Լ�
	train=~test; %ȡtest�Ĳ�����Ϊѵ����
	TrainData=x_train(train,:); %��ȡѵ�������� 
	TestData=x_train(test,:); %��ȡ���Լ�����
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
