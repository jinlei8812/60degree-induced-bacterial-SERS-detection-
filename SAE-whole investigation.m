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
[n,m]=size(x_train);
CVSAE=[];
SAE_Avreage=[];
SAE_sigma=[];
%% CV
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
%% softmax classifier
hiddenSize=50;
autoenc = trainAutoencoder(TrainData', hiddenSize,'MaxEpochs',800, ...
    'L2WeightRegularization', 0.01, ...
    'SparsityRegularization', 4, ...
    'SparsityProportion', 0.05, ...
    'DecoderTransferFunction','purelin');
feat1 = encode(autoenc,TrainData');
trainlabel_out=transfer(Label_train,2);
softnet = trainSoftmaxLayer(feat1,trainlabel_out','MaxEpochs',400);
stackednet = stack(autoenc,softnet);
%% Compute accuracy
Y_pre1 = stackednet(TestData');
%%  caculation
output_pre1=math_transfer(Y_pre1);% ��������ת��Ϊ0��1�������Y_re��ֵС��0.5����Ϊ0
Y_pre=bina_transfer(output_pre1);% ��������ת��Ϊ1�����еĶ�����
resum=[Label_test,Y_pre];
statis_SAE=CVaccuration( Label_test,Y_pre,2);
CVSAE=[CVSAE;statis_SAE];
end
end
SAE_Avreage=mean(CVSAE);
SAE_sigma=std(CVSAE);
