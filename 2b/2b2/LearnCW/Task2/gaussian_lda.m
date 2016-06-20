means = zeros(10,100);
confMatGLDA = zeros(10);
priorP = zeros(1,10);
covMat = bsxfun(@minus,train_features,sum(train_features)/10000);
covMat = (covMat'*covMat)/9999;
det2 = det(covMat);
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
    priorP(i) = count/10000;
end
for i = 1:1000
    prob = zeros(1,10);
    for j = 1:10
        M = means(j,:);
        C = covMat;
        X = test_features(i,:);
        prob(j) = -0.5*((X-M)*inv(C)*(X-M)') - 0.5*log(det(C)) + log(priorP(j));
    end
    index = find(prob==max(prob));
    acin = test_classes(i);
    confMatGLDA(acin,index) = confMatGLDA(acin,index) +1;
end