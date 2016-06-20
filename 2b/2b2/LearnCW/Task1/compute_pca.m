function [ EVecs, EVals ] = compute_pca( X )
    [EVecs2,EVals2] = eig(MyCov(X));
    EVals2 = sum(EVals2,2);
    d = size(X,2);
    EVecs = zeros(d);
    EVals = zeros(d,1);
    for i = 1:d
        index = find(EVals2 == max(EVals2));
        ev = EVecs2(:,index);
        if ev(1) >=0
            EVecs(:,i) = ev;
        else
            EVecs(:,i) = -ev;
        end
        EVals(i,:) = EVals2(index,:);
        EVecs2(:,index) = [];
        EVals2(index,:) = [];
    end  
end

function [ M ] = MyMean( A )
    M = sum(A)/size(A,1);
end

function [ S ] = MyCov( A )
    M = MyMean(A);
    X = bsxfun(@minus,A,M);
    S = (X'*X)/(size(A,1)-1);
end



