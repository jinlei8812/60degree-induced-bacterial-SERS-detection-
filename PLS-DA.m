%% data substraction
clc,clear;
x1=load('BacSERS_forward_selec1.mat');
x2=load('BacSERS_backward_selec1.mat');
y1=load('forwardselect1_label.mat');
y2=load('backwardselect1_label.mat');
X_bacteria=[x1.X_bacforward_select1;x2.X_bacward_select1];
Label=[y1.y_label;y2.y_label];
x_tr=mapminmax(X_bacteria,0,1);
[n,m]=size(x_tr);
X=bacteria_score;
Y=y_label;
%% 训练集划分计算
testRatio = 0.2;
% 训练集索引
trainIndices = crossvalind('HoldOut', n, testRatio);
% 测试集索引
%save('trainIndices.mat','trainIndices')
testIndices = ~trainIndices;
% 训练集和训练标签
trainData = X(trainIndices, :);
trainLabel =Y(trainIndices, :);
%save('trainData.mat','trainData')
%save('trainLabel.mat','trainLabel')
% 测试集和测试标签
testData = X(testIndices, :);
testLabel = Y(testIndices, :);
%save('testData.mat','testData')
%save('testLabel.mat','testLabel')
%% 计算
[n1,m1]=size(trainData);
[n2,m2]=size(testData);
N=n1-0;
X=trainData(1:N,:);
%[n,m]=size(X);
y=trainLabel(1:N,:);
NCOMP=10;
[XL,yl,XS,YS,beta,PCTVAR] = plsregress(X,y,NCOMP);
plot(1:NCOMP,cumsum(100*PCTVAR(2,:)),'-bo');
xlabel('Number of PLS components');
ylabel('Percent Variance Explained in y');
%% 选择前NCOMP个主成分
[Xloadings,Yloadings,Xscores,Yscores,beta_t] = plsregress(X,y,NCOMP);
yfitPLS = [ones(N,1) X]*beta_t;
%Plot fitted vs. observed response for the PLSR and PCR fits.
plot(y,yfitPLS,'bo');
xlabel('Observed Response');
ylabel('Fitted Response');
legend({'PLSR with 10 Components'},  ...
	'location','NW');
% 计算Rc2
TSS = sum((y-mean(y)).^2);
RSS_PLS = sum((y-yfitPLS).^2);
rsquaredPLS = 1 - RSS_PLS/TSS
RMSEC=(RSS_PLS/N)^0.5;

%% 考察模型预测性能(去除最后一个坏点）
Y_pre=[ones((n2),1) testData]*beta_t;
RSS_P = sum((testLabel-Y_pre).^2);
TSS_P = sum((testLabel-mean(testLabel)).^2);
rsquaredPLS_p = 1 - RSS_P/TSS_P
RMSEC_P=(RSS_P/n2).^0.5
%% VIP computation
[XL,YL,XS,YS,beta,pctvar,mse,stats] = plsregress(trainData ,trainLabel ,NCOMP);
% Calculate normalized PLS weights
W0 = bsxfun(@rdivide,stats.W,sqrt(sum(stats.W.^2,1)));
% Calculate the product of summed squares of XS and YL
sumSq = sum(XS.^2,1).*sum(YL.^2,1);
% Calculate VIP scores for NCOMP components
vipScores = sqrt(size(XL,1) * sum(bsxfun(@times,sumSq,W0.^2),2) ./ sum(sumSq,2));
%save('vipScores.txt','vipScores');
%save('x_axis.txt','x_axis');
x_ax=load('x_axis.mat');
x_ax2=x_ax.x_axis;
plot(x_ax2,vipScores);
XX=[x_ax2, vipScores];
save('vipscore','XX');
hold on
%%  Compute accuracy
acu=0;
for i=1:size(Y_pre,1)
    if abs(Y_pre(i,:)-testLabel(i,:))>0.5
        acu=acu+1;
    end
end
Accuracy=100-100*acu/size(Y_pre,1);
