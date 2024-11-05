%%二维云图：
%% 提取Blooding O157金浦
clear,clc;
x1_blood_o157=load('fina_bloodO157.mat');
blood_O157_h7=x1_blood_o157.a';
[n2,~]=size(blood_O157_h7);
label_blood_O157_h7=ones(n2,1);


%% 提取O157:H7光谱
x1_o157=load('fina_O157H7.mat');
O157_h7=x1_o157.a';
[n1,~]=size(O157_h7);
label_O157_h7=2*ones(n1,1);
%% 提取non- O157金浦
x1_non157=load('fina_non_O157.mat');
Non157=x1_non157.a';
[n3,m3]=size(Non157);
label_Non157=2*ones(n3,1);

mean_nonEHEC=mean([O157_h7;Non157])';
SD_nonEHEC=std([O157_h7;Non157])';
%RSD_EHEC=SD_EHEC./mean_EHEC;
%% 合并数据集
x_train=[blood_O157_h7;O157_h7;Non157];
y_label=[label_blood_O157_h7;label_O157_h7;label_Non157];
%% K-fold crassvalid交叉验证计算labelNon157
%x_train=bacteria_score;
[n,m]=size(x_train);
CVDT=[];
DT_Avreage=[];
DT_sigma=[];
%% CV
k=10;
indices=crossvalind('KFold',n,k);
%% calculation
for j=1:15
for i=1:k
	test=(indices==i); %结果为逻辑值，每次循环选取一个组作为测试集
	train=~test; %取test的补集即为训练集
	TrainData=x_train(train,:); %提取训练集数据 
	TestData=x_train(test,:); %提取测试集数据
    Label_train=y_label(train,:);
    Label_test=y_label(test,:);
%% softmax classifier
trainlabel_out=transfer(Label_train,2);
net = trainSoftmaxLayer(TrainData',trainlabel_out','MaxEpochs',500);
Y_pre1= net(TestData');
output_pre1=math_transfer(Y_pre1);% 将计算结果转化为0和1，即如果Y_re的值小于0.5，则为0
Y_pre=bina_transfer(output_pre1);% 将计算结果转化为1个阵列的多种类
resum=[Label_test,Y_pre];
statis_DT=CVaccuration( Label_test,Y_pre,2);
CVDT=[CVDT;statis_DT];
end
end
DT_Avreage=[DT_Avreage;mean(CVDT)];
DT_sigma=[std(CVDT);DT_sigma];

%%
%% 训练集划分计算
X=x_train;
Y=y_label;
[n,m]=size(X);
testRatio = 0.2;
% 训练集索引
trainIndices = crossvalind('HoldOut', n, testRatio);
% 测试集索引
%save('trainIndices.mat','trainIndices')
testIndices = ~trainIndices;
% 训练集和训练标签
TrainData = X(trainIndices, :);
Label_train =Y(trainIndices, :);
%save('trainData.mat','trainData')
%save('trainLabel.mat','trainLabel')
% 测试集和测试标签
TestData= X(testIndices, :);
Label_test = Y(testIndices, :);
%save('testData.mat','testData')
%save('testLabel.mat','testLabel')
%% SOftmax
%% softmax classifier
trainlabel_out=transfer(Label_train,2);
net = trainSoftmaxLayer(TrainData',trainlabel_out','MaxEpochs',500);
Y_pre1= net(TestData');
output_pre1=math_transfer(Y_pre1);% 将计算结果转化为0和1，即如果Y_re的值小于0.5，则为0
Y_pre=bina_transfer(output_pre1);% 将计算结果转化为1个阵列的多种类
resum=[Label_test,Y_pre];
statis_DT=CVaccuration( Label_test,Y_pre,2);
%CVDT=[CVDT;statis_DT];
%% confusion matrix
m=confusionmat(Label_test,Y_pre);
%statesNE = ["EHEC","non-EHEC "]
statesNE = ["non-EHEC ","EHEC",]
classlabels=categorical(statesNE);
cm = confusionchart(m,classlabels);
cm.Normalization = 'row-normalized';
sortClasses(cm,'descending-diagonal');
cm.Normalization = 'absolute';
%% %% save 
