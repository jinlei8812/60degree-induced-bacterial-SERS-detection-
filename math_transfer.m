function output=math_transfer(Input)
%This function convert limit numer to 0 and 1
[n,m]=size(Input);
for j=1:m
    int=[];
    for i=1:n
       % if (abs(Input(i,j)<0.5))
       %     Input(i,j)=0;
      %  else Input(i,j)=1;
      int=[int;Input(i,j)];
    end
    [~,b]=max(int);
    for k=1:n
        if (k==b)
            Input(k,j)=1;
        else
             Input(k,j)=0;
        end
    end
end
output=Input;