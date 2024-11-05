%% 提取光谱
clc,clear;
x1=load('train_spectra.mat');
x_tr=x1.spectra_train;
x_train=x_tr;
%x_train=zscore(x_tr);
y1=load('label_train.mat');
y_label=y1.Label;
TrainData=x_train; %提取训练集数据 
Label_train=y_label;
%% 测试集
x_test1=load('X_test_bacteria.mat');
x_test2=x_test1.X_test_bacteria;
%% nosie
Num=42;
sigma=0.2;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
stdr= std(x_test2); %noise standard deviation
x_test3 = x_test2 + repmat(sigma*stdr, size(x_test2,1),1).*randn(size(x_test2));
x_test = x_test3;
 %Ramsn shift
raman=load('raman_axis.mat');
raman=raman.x_axis;
for i=1:5
    subplot(2,3,i);
    ramanspectra=mean(x_test((Num*(i-1)+1):Num*i,:));
    plot(raman,ramanspectra);
    xlabel ('Raman shift/cm^{-1}');
    ylabel('Intensity/a.u.');
   hold on
end
%% RF
RF=[];
SC=[];
ELM=[];
DT=[];
SAE=[];
PLSDA=[];
LDA=[];
pre_RF=[];
pre_SC=[];
pre_ELM=[];
pre_DT=[];
pre_SAE=[];
pre_PLSDA=[];
pre_LDA=[];
for i=1:30
B = TreeBagger(50,TrainData,Label_train,'Method','classification');
 %% RF Generation ability test  caculation
test_label = predict(B,x_test);
T_sim=cell2mat(test_label);
Y_pre_RF=str2num(T_sim);
statis_RF=accuration( Y_pre_RF,5,Num);
RF=[statis_RF,RF];
pre_RF=[Y_pre_RF,pre_RF];
%Result=[test_label,Y_pre_test];
%% softmax clssifier training and test
trainlabel_out=transfer(Label_train,5);
net = trainSoftmaxLayer(TrainData',trainlabel_out','MaxEpochs',200);
Y_pre1= net(x_test');
output_pre1=math_transfer(Y_pre1);% 将计算结果转化为0和1，即如果Y_re的值小于0.5，则为0
Y_pre_SC=bina_transfer(output_pre1);% 将计算结果转化为1个阵列的多种类
statis_SC=accuration( Y_pre_SC,5,Num);
SC=[statis_SC,SC];
pre_SC=[Y_pre_SC,pre_SC];
%% SAE
hiddenSize=100;
autoenc = trainAutoencoder(TrainData', hiddenSize,'MaxEpochs',400, ...
    'L2WeightRegularization', 0.001, ...
    'SparsityRegularization', 4, ...
    'SparsityProportion', 0.05, ...
    'DecoderTransferFunction','purelin');
feat1 = encode(autoenc,TrainData');
trainlabel_out=transfer(Label_train,5);
softnet = trainSoftmaxLayer(feat1,trainlabel_out','MaxEpochs',400);
stackednet = stack(autoenc,softnet);
Y_pre2 = stackednet(x_test');
%%  caculation
output_pre2=math_transfer(Y_pre2);% 将计算结果转化为0和1，即如果Y_re的值小于0.5，则为0
Y_pre_SAE=bina_transfer(output_pre2);% 将计算结果转化为1个阵列的多种类net=fitctree(TrainData,Label_train);
statis_SAE=accuration( Y_pre_SAE,5,Num);
SAE=[statis_SAE,SAE];
pre_SAE=[Y_pre_SAE,pre_SAE];
%% Decesion tree
net=fitctree(TrainData,Label_train);
Y_pre_DT=predict(net,x_test);
statis_DT=accuration( Y_pre_DT,5,Num);
DT=[statis_DT,DT];
pre_DT=[Y_pre_DT,pre_DT];
%% ELM
    P_train=TrainData';
    T_train= Label_train';
    P_test=x_test';
    %T_test=Label_test';
% net
   [IW,B,LW,TF,TYPE] = elmtrain(P_train,T_train,100,'sig',1);
   Y_pre_ELM = elmpredict(P_test,IW,B,LW,TF,TYPE)';
   statis_ELM=accuration( Y_pre_ELM,5,Num);
   ELM=[statis_ELM,ELM];
   pre_ELM=[Y_pre_ELM,pre_ELM];
   %% LDA
X=TrainData;
Y= Label_train;
Mdl = fitcdiscr(X,Y);
newX=x_test;
[Y_pre_LDA,score] = predict(Mdl,newX);
statis_LDA=accuration( Y_pre_LDA,5,Num);
LDA=[statis_LDA,LDA];
pre_LDA=[Y_pre_LDA,pre_LDA];
    %% PLS_DA caculation
	[n1,m1]=size(TrainData);
    [n2,m2]=size(x_test);
    N=n1-0;
    X=TrainData(1:N,:);
    y=Label_train(1:N,:);
    NCOMP=10;
    [Xloadings,Yloadings,Xscores,Yscores,beta_t] = plsregress(X,y,NCOMP);
%% 考察模型预测性能(去除最后一个坏点）
    Y_pre=[ones((n2),1) x_test]*beta_t;
    Label_test=[ones(Num,1);2*ones(Num,1);3*ones(Num,1);4*ones(Num,1);5*ones(Num,1)];
    % calculation accuracy
   %  Compute accurac
   % acu=0;
    for j=1:size(Y_pre,1)
         if  abs(Y_pre(j,:)-Label_test(j,:))<0.5
              Y_pre(j,:)=Label_test(j,:);
         else Y_pre(j,:)=round(Y_pre(j,:));
         end
    end
Y_pre_PLSDA=Y_pre;
statis_PLSDA=accuration( Y_pre_PLSDA,5,Num);
PLSDA=[statis_PLSDA,PLSDA];
pre_PLSDA=[Y_pre_PLSDA,pre_PLSDA];
end
%%
accuracy_RF=mean(RF');
accuracy_sc=mean(SC');
accuracy_DT=mean(DT');
accuracy_SAE=mean(SAE');
accuracy_LDA=mean(LDA');
accuracy_ELM=mean(ELM');
accuracy_PLSDA=mean(PLSDA');
%plotconfusion(targets1,outputs1,name1,targets2,outputs2,name2,...,targetsn,outputsn,namen)