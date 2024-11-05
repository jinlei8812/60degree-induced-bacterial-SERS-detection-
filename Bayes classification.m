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

%% ��Ҷ˹����
CVSC=[];
%SC_Avreage=[];
%SC_sigma=[];
for i=1:15
	TrainData=x_train; %��ȡѵ�������� 
	TestData=x_test; %��ȡ���Լ�����
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