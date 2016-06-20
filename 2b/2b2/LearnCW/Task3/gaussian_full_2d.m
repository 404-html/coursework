means = zeros(10,2);
covMat = zeros(2,2,10);
confMatGF2d = zeros(10);
for i = 1:10
    class_feature = zeros(10000,2);
    count = 0;
    for j = 1:10000
        if train_classes(j) == i;
            count = count + 1;
            class_feature(count,1:2) = train_features(j,1:2);
        end
    end
    means(i,:) = sum(class_feature)/count;
    class_feature((count+1):10000,:) = [];
    class_feature = bsxfun(@minus,class_feature,means(i,:));
    covMat(:,:,i) = (class_feature' * class_feature)/(count-1);
end
for i = 1:1000
    prob = zeros(1,10);
    for j = 1:10
        M = means(j,:);
        C = covMat(:,:,j);
        X = test_features(i,1:2);
        prob(j) = (1/sqrt(((2*pi)^2)*det(C))) * exp(-0.5*(X-M)*inv(C)*(X-M)');
    end
    index = find(prob==max(prob));
    acin = test_classes(i);
    confMatGF2d(acin,index) = confMatGF2d(acin,index) +1;
end