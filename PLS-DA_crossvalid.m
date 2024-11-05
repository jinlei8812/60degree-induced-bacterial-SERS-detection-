%% 提取光谱
clc,clear;
%% 训练集
x1=load('train_spectra.mat');
x_train=x1.spectra_train;
y1=load('label_train.mat');
y_train_label=y1.Label_train;
%% 测试集
x2=load('test_spectra.mat');
x_test=x2.spectra_test;
y2=load('label_test.mat');
y_test_label=y2.Label;
%% K-fold crassvalid交叉验证计算
%x_train=bacteria_score;
%x_test=y_label;
CVSC=[];
[n1,m1]=size(x_train);
[n2,m2]=size(x_test);
for i=1:15
%% RF caculation
    NCOMP=10;
    [Xloadings,Yloadings,Xscores,Yscores,beta_t] = plsregress(x_train,y_train_label,NCOMP);
%% 考察模型预测性能(去除最后一个坏点）
    Y_pre=[ones((n2),1) x_test]*beta_t;
    for j=1:size(Y_pre,1)
         if  abs(Y_pre(j,:)-y_test_label(j,:))<0.5
              Y_pre(j,:)=y_test_label(j,:);
         else Y_pre(j,:)=round(Y_pre(j,:));
         end
    end
 resum=[y_test_label,Y_pre];
 statis_SC=CVaccuration(y_test_label,Y_pre,4);
CVSC=[CVSC;statis_SC];
end
SC_Avreage=mean(CVSC);
SC_sigma=std(CVSC);