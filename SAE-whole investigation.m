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
	test=(indices==i); %结果为逻辑值，每次循环选取一个组作为测试集
	train=~test; %取test的补集即为训练集
	TrainData=x_train(train,:); %提取训练集数据 
	TestData=x_train(test,:); %提取测试集数据
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
output_pre1=math_transfer(Y_pre1);% 将计算结果转化为0和1，即如果Y_re的值小于0.5，则为0
Y_pre=bina_transfer(output_pre1);% 将计算结果转化为1个阵列的多种类
resum=[Label_test,Y_pre];
statis_SAE=CVaccuration( Label_test,Y_pre,2);
CVSAE=[CVSAE;statis_SAE];
end
end
SAE_Avreage=mean(CVSAE);
SAE_sigma=std(CVSAE);
