%% SERS spectra outlier: PCA-mali distance
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
[coeff, score, latent, tsquar]=pca(X);
per=latent/sum( latent);
%% mali distance
X_new=score(:,1:14);
cov1=cov(X_new);
avreage=mean(X_new);
for i=1:n
    D(i)=((X_new(i,:)-avreage)*inv(cov1)*(X_new(i,:)-avreage)')^0.5;
end
%% outlier
sigma=std(D);
avr=mean(D);
border=avr+2*sigma;
output=[];
for i=1:n
    if(D(:,i)>border)
        output=[output,i];
    end
end
 %% rearrange SERS spectra
spectra_select=[];
label_select=[];
k=0;
 for i=1:n
  flag=1;
      for j=1:size(output,2)
         if (i==output(:,j))
             flag=0;
             break;
         end
      end
      if (flag&&(j==size(output,2)))
          k=i;
          spectra_select=[spectra_select;X(k,:)];
          label_select=[label_select;y_label(k,:)];
      end
end  