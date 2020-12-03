function X = myfftbk(x)
x = reshape(x,[],1);
N = length(x);
indices = 1:N;
rindices = bitrevorder(indices);

levelSum = x(rindices);
level = log(N)/log(2);

W = W_N(0:N-1,N);
for i = 1:level
    pool = [levelSum,levelSum];    
    coef = W(1:2^(level-i):N);
    coef = reshape(coef,[],2);
    
    %需要处理索引，间隔和个数。
    index = 2^(i-1)+1:2^i;            %索引
    
    count = 2^(level-i);              %个数
    index = repmat(index,count,1)';
    
    intvl = reshape((0:2^i:N-2),1,[]);%间隔
    index = index+intvl;
    
    pool(index,:) = pool(index,:).*repmat(coef,2^(level-i),1);
    
    lgcidx = false(size(pool,1),1);
    lgcidx(index) = 1;
    sftidxup = lgcidx;
    sftidxdn = ~sftidxup;
    
    pool(:,1) = circshift(pool(:,1).*sftidxup,-2^(i-1))+pool(:,1).*(~sftidxup);
    pool(:,2) = circshift(pool(:,2).*sftidxdn,2^(i-1))+pool(:,2).*(~sftidxdn);
    
    levelSum = sum(pool,2);        %移位乘法求和
end
X = levelSum;

function W = W_N(k,N)
W = exp((-1i*2*pi*k)./N);