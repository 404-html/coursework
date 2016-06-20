function [ S ] = MyCov( A )
    M = MyMean(A);
    X = bsxfun(@minus,A,M);
    S = (X'*X)/(size(A,1)-1);
end

