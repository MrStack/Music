function X = myfft(x)
x = reshape(x,[],1);
N = length(x);
indices = 1:N;
rindices = bitrevorder(indices);

levelSum = x(rindices);
level = log(N)/log(2);

for i = 1:level
    pool = [levelSum,levelSum];
    W = W_N(0:N-1,N);
    coef = W(1:2^(level-i):N);
    coef = reshape(coef,[],2);
    
    %需要处理索引，间隔和个数。
    index = 2^(i-1)+1:2^i;         %索引
    
    count = 2^(level-i);           %个数
    index = repmat(index,count,1); 
    
    index = index+2^i;             %间隔
    
    pool(index,:) = pool(index,:).*repmat(coef,2^(level-i),1);
    
    levelSum                       %移位乘法求和；
end

% 
% oddrx = x(rindices(1:2:N));
% oddrx = [oddrx,oddrx];
% oddrx = reshape(oddrx,[],1);
% 
% evenrx = x(rindices(2:2:N));
% evenrx = [evenrx,evenrx];
% evenrx = reshape(evenrx,[],1);
% 
% W = W_N(0:N-1,N);
% 
% level = log(N)/log(2);
% for i = 1:level
%     coef = W(1:2^(level-i):N);
%     coef = repmat(coef,2^(level-1)-1,1);
%     levelSum = oddrx+evenrx.*coef;
% end

function W = W_N(k,N)
W = exp((-1i*2*pi*k)./N);