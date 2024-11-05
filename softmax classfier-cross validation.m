%% ��ȡ����
clc,clear;
%% ѵ����
x1=load('train_spectra.mat');
x_train=x1.spectra_train;
y1=load('label_train.mat');
y_train_label=y1.Label_train;
%% ���Լ�
x2=load('test_spectra.mat');
x_test=x2.spectra_test;
y2=load('label_test.mat');
y_test_label=y2.Label;
%% K-fold crassvalid������֤����
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
	test=(indices==i); %���Ϊ�߼�ֵ��ÿ��ѭ��ѡȡһ������Ϊ���Լ�
	train=~test; %ȡtest�Ĳ�����Ϊѵ����
	TrainData=x_train(train,:); %��ȡѵ�������� 
	TestData=x_train(test,:); %��ȡ���Լ�����
    Label_train=y_train_label(train,:);
    Label_test=y_train_label(test,:);
    %% RF caculation
trainlabel_out=transfer(Label_train,4);
net = trainSoftmaxLayer(TrainData',trainlabel_out','MaxEpochs',500);
Y_pre1= net(TestData');
output_pre1=math_transfer(Y_pre1);% ��������ת��Ϊ0��1�������Y_re��ֵС��0.5����Ϊ0
Y_pre=bina_transfer(output_pre1);% ��������ת��Ϊ1�����еĶ�����
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