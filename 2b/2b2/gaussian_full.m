means = zeros(10,100);
covMat = zeros(100,100,10);
determinant = zeros(1,10);
confMatGF = zeros(10);
for i = 1:10
    class_feature = zeros(10000,100);
    count = 0;
    for j = 1:10000
        if train_classes(j) == i;
            count = count + 1;
            class_feature(count,:) = train_features(j,:);
        end
    end
    means(i,:) = sum(class_feature)/count;
    class_feature((count+1):10000,:) = [];
    class_feature = bsxfun(@minus,class_feature,means(i,:));
    covMat(:,:,i) = (class_feature' * class_feature)/(count-1);
    determinant(i) = det(covMat(:,:,i));
end
for i = 1:1000
    prob = zeros(1,10);
    for j = 1:10
        M = means(j,:);
        C = covMat(:,:,j);
        X = test_features(i,:);
        prob(j) = (1/sqrt(((2*pi)^100)*det(C))) * exp((-0.5*(X-M)/C)*(X-M)');
    end
    index = find(prob==max(prob));
    acin = test_classes(i);
    confMatGF(acin,index) = confMatGF(acin,index) +1;
end
acc_gf = sum(diag(confMatGF))/1000;

%Confusion matrix is stored in confMatGF, determinant in determinant,
%accuracy in acc_gf