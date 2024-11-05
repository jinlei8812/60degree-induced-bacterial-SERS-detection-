clc,clear;
x1=load('bacteria_SERS.mat');
X_bacteria=x1.X_bacteria';
y1=load('bacteria_label.mat');
y_label=y1.label;
x_tr=mapminmax(X_bacteria,0,1);
[n,m]=size(x_tr);
X1=x_tr;
Y=y_label;
%% PCA
[coeff, score, latent, tsquar]=pca(X1);
per=latent/sum( latent);
%% ѵ�������ּ���
N=7;
X=score(:,1:N);
testRatio = 0.2;
% ѵ��������
trainIndices = crossvalind('HoldOut', n, testRatio);
% ���Լ�����
%save('trainIndices.mat','trainIndices')
testIndices = ~trainIndices;
% ѵ������ѵ����ǩ
trainData = X(trainIndices, :);
trainLabel =Y(trainIndices, :);
%save('trainData.mat','trainData')
%save('trainLabel.mat','trainLabel')
% ���Լ��Ͳ��Ա�ǩ
testData = X(testIndices, :);
testLabel = Y(testIndices, :);
%save('testData.mat','testData')
%save('testLabel.mat','testLabel')
%% ������
%ctree=ClassificationTree.fit();
%view(ctree,'Mode','graph')
%T_sim=predict(ctree,testData );


%% random forest
B = TreeBagger(50,trainData,trainLabel,'Method','classification');
predict_label = predict(B,testData);
T_sim=cell2mat(predict_label);
Y_pre=str2num(T_sim);
%% accuracy
acu=0;
for i=1:size(Y_pre,1)
    if abs(Y_pre(i,:)-testLabel(i,:))>0.5
        acu=acu+1;
    end
end
Accuracy=100-100*acu/size(Y_pre,1);

