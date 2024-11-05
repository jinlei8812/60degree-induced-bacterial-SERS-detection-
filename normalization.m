function sddata=normalization (x)
%% data normalization
stdr=std(x);
[n,m]=size(stdr);
sddata=x./stdr(ones(n,1),1);