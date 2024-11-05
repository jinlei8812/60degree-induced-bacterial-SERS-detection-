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
%x_train=bacteria_score;
%x_test=y_label;
CVSAE=[];
%% CV
%% calculation
for i=1:15
	TrainData=x_train; %��ȡѵ�������� 
	TestData=x_test; %��ȡ���Լ�����
    Label_train=y_train_label;
    Label_test=y_test_label;
%% softmax classifier
hiddenSize=50;
autoenc = trainAutoencoder(TrainData', hiddenSize,'MaxEpochs',500, ...
    'L2WeightRegularization', 0.01, ...
    'SparsityRegularization', 4, ...
    'SparsityProportion', 0.05, ...
    'DecoderTransferFunction','purelin');
feat1 = encode(autoenc,TrainData');
trainlabel_out=transfer(Label_train,4);
softnet = trainSoftmaxLayer(feat1,trainlabel_out','MaxEpochs',500);
stackednet = stack(autoenc,softnet);
%% Compute accuracy
Y_pre1 = stackednet(TestData');
%%  caculation
output_pre1=math_transfer(Y_pre1);% ��������ת��Ϊ0��1�������Y_re��ֵС��0.5����Ϊ0
Y_pre=bina_transfer(output_pre1);% ��������ת��Ϊ1�����еĶ�����
resum=[Label_test,Y_pre];
statis_SAE=CVaccuration( Label_test,Y_pre,4);
CVSAE=[CVSAE;statis_SAE];
end
SAE_Avreage=mean(CVSAE);
SAE_sigma=std(CVSAE);
