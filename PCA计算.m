clc,clear
x0=load('wholedata.mat');
x_tr=x0.X;
[n,m]=size(x_tr);
A=[1,2,3,4,5,6];
Y0=repmat(A,90,1);
y_tr=reshape(Y0,m,1);
X=x_tr';
Y=y_tr;

%% PCA
%x=X;
%stdr=std(x);
%[n,m]=size(x);
%sddata=x./stdr(ones(n,1),:);
X=[fina_jinpu_blank(:,2:end),fina_jinpu_antbio(:,2:end)]';
X_pca=mapminmax(X,0,1);
[coeff, score, latent, tsquar]=pca(x_train);
per=latent/sum( latent);
N=90;
x_axis=load('x_axis.mat');
x_var=x_axis.x_axis;
plot(x_var',coeff(:,1));
%score=Xloadings;
%% 画图
  %% 大肠
       i=1
       xdat=score(1:n1,1:3);
       xm = mean(xdat);
       [m,n] = size(xdat);
       n = max(m,n);
       x = xdat(:,1);
        y = xdat(:,2);
        z = xdat(:,3);
        s = inv(cov(xdat));  % 协方差矩阵
        xd = xdat-repmat(xm,[n,1]);
        rd = sum(xd*s.*xd,2);
        r = prctile(rd,100*(1-0.05));
        plot3(x(rd<=r),y(rd<=r),z(rd<=r),'b.','MarkerSize',25)  % 画样本散点
        hold on
        plot3(x(rd>r),y(rd>r),z(rd>r),'b+','MarkerSize',10)  % 画样本散点
        %plot3(xm(1),xm(2),xm(3),'k+');  % 椭球中心
        h = ellipsefig(xm,s,r,2);  % 绘制置信椭球
        xlabel('X')
        ylabel('Y')
        zlabel('Z')
hold on
i=2 
       xdat=score(n1+1:end,1:3);
       xm = mean(xdat);
       [m,n] = size(xdat);
       n = max(m,n);
       x = xdat(:,1);
        y = xdat(:,2);
        z = xdat(:,3);
        s = inv(cov(xdat));  % 协方差矩阵
        xd = xdat-repmat(xm,[n,1]);
        rd = sum(xd*s.*xd,2);
        r = prctile(rd,100*(1-0.05));
        plot3(x(rd<=r),y(rd<=r),z(rd<=r),'k.','MarkerSize',25)  % 画样本散点
        hold on
        plot3(x(rd>r),y(rd>r),z(rd>r),'k+','MarkerSize',10)  % 画样本散点
        %plot3(xm(1),xm(2),xm(3),'k+');  % 椭球中心
        h = ellipsefig(xm,s,r,2);  % 绘制置信椭球
        xlabel('X')
        ylabel('Y')
        zlabel('Z')
     hold on
      view([0,0])  
    i=3
       xdat=score(N*i-(N-1):N*i,1:3);
       xm = mean(xdat);
       [m,n] = size(xdat);
       n = max(m,n);
       x = xdat(:,1);
        y = xdat(:,2);
        z = xdat(:,3);
        s = inv(cov(xdat));  % 协方差矩阵
        xd = xdat-repmat(xm,[n,1]);
        rd = sum(xd*s.*xd,2);
        r = prctile(rd,100*(1-0.05));
        plot3(x(rd<=r),y(rd<=r),z(rd<=r),'y.','MarkerSize',25)  % 画样本散点
        hold on
        plot3(x(rd>r),y(rd>r),z(rd>r),'y+','MarkerSize',10)  % 画样本散点
        %plot3(xm(1),xm(2),xm(3),'k+');  % 椭球中心
        h = ellipsefig(xm,s,r,2);  % 绘制置信椭球
        xlabel('X')
        ylabel('Y')
        zlabel('Z')
        hold on
        
    i=4
       xdat=score(N*i-(N-1):N*i,1:3);
       xm = mean(xdat);
       [m,n] = size(xdat);
       n = max(m,n);
       x = xdat(:,1);
        y = xdat(:,2);
        z = xdat(:,3);
        s = inv(cov(xdat));  % 协方差矩阵
        xd = xdat-repmat(xm,[n,1]);
        rd = sum(xd*s.*xd,2);
        r = prctile(rd,100*(1-0.05));
        plot3(x(rd<=r),y(rd<=r),z(rd<=r),'g.','MarkerSize',25)  % 画样本散点
        hold on
        plot3(x(rd>r),y(rd>r),z(rd>r),'g+','MarkerSize',10)  % 画样本散点
        %plot3(xm(1),xm(2),xm(3),'k+');  % 椭球中心
        h = ellipsefig(xm,s,r,2);  % 绘制置信椭球
        xlabel('X')
        ylabel('Y')
        zlabel('Z')
         hold on
        
    i=5
       xdat=score(N*i-(N-1):N*i,1:3);
       xm = mean(xdat);
       [m,n] = size(xdat);
       n = max(m,n);
       x = xdat(:,1);
        y = xdat(:,2);
        z = xdat(:,3);
        s = inv(cov(xdat));  % 协方差矩阵
        xd = xdat-repmat(xm,[n,1]);
        rd = sum(xd*s.*xd,2);
        r = prctile(rd,100*(1-0.05));
        plot3(x(rd<=r),y(rd<=r),z(rd<=r),'c.','MarkerSize',25)  % 画样本散点
        hold on
        plot3(x(rd>r),y(rd>r),z(rd>r),'c+','MarkerSize',10)  % 画样本散点
        %plot3(xm(1),xm(2),xm(3),'k+');  % 椭球中心
        h = ellipsefig(xm,s,r,2);  % 绘制置信椭球
        xlabel('X')
        ylabel('Y')
        zlabel('Z')
        hold on
        
    i=6
       xdat=score(N*i-(N-1):N*i,1:3);
       xm = mean(xdat);
       [m,n] = size(xdat);
       n = max(m,n);
       x = xdat(:,1);
        y = xdat(:,2);
        z = xdat(:,3);
        s = inv(cov(xdat));  % 协方差矩阵
        xd = xdat-repmat(xm,[n,1]);
        rd = sum(xd*s.*xd,2);
        r = prctile(rd,100*(1-0.05));
        plot3(x(rd<=r),y(rd<=r),z(rd<=r),'b.','MarkerSize',25)  % 画样本散点
        hold on
        plot3(x(rd>r),y(rd>r),z(rd>r),'b+','MarkerSize',10)  % 画样本散点
        %plot3(xm(1),xm(2),xm(3),'k+');  % 椭球中心
        h = ellipsefig(xm,s,r,2);  % 绘制置信椭球
        xlabel('X')
        ylabel('Y')
        zlabel('Z')
        %axis equal;

%% 载荷系数
plot(x_ax2',score(1,:));

  scatter3(score(:,1),score(:,2),score(:,3))
     