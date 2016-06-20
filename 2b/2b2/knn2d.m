% change the value of K here
K = 1;
nn = zeros(1,K);
confMat2d = zeros(10);
for i = 1:1000
    sqdist = sum(bsxfun(@minus,train_features(:,1:2),test_features(i,1:2)).^2,2);
    for k = 1:K
        index = find(sqdist == min(sqdist));
        nn(k) = train_classes(index);
        sqdist(index) = [];
    end
    % find the mode
    nnelem = unique(nn);
    nnelemfreq = histc(nn,nnelem);
    % eliminate non-mode numbers
    for j = 1:(size(nnelem,2))
        if nnelemfreq(j) < max(nnelemfreq)
            nn(nn==nnelem(j)) = [];
        end
    end
    % take the first mode
    mode = nn(1);
    % ac stands for actual class.
    ac = test_classes(i);
    % filling the confusion matrix.
    confMat2d(ac,mode) = confMat2d(ac,mode) + 1;
end