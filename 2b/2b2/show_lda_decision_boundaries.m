hold on;

%adjust the region intervals here
interval = 0.04;
repeats = 16 * (1/interval) +1;
totlength = repeats * repeats;
Xs = repmat(-8:interval:8,1,repeats);
Ys = reshape(repmat(-8:interval:8,repeats,1),1,totlength);
color = [1 0 0;0 1 0;0 0 1;1 1 0;1 0 1;0 1 1;0 0 0;0.5 0.5 0.5;0.5 0.5 0;0.5 0 0.5];
color2 = [1 0.5 0.5;0.75 1 0.75;0.5 0.5 1;1 1 0.5;1 0.5 1;0.5 1 1;0.5 0.5 0.5;0.75 0.75 0.75;0.75 0.75 0.5;0.75 0.5 0.75];
colors = zeros(totlength,3);

means = zeros(10,2);
confMatGLDA = zeros(10);
priorP = zeros(1,10);
covMat = bsxfun(@minus,train_features(:,1:2),sum(train_features(:,1:2))/10000);
covMat = (covMat'*covMat)/9999;
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
    priorP(i) = count/10000;
end

for i = 1:totlength
    prob = zeros(1,10);
    for j = 1:10
        M = means(j,:);
        C = covMat;
        X = [Xs(i),Ys(i)];
        prob(j) = -0.5*((X-M)*inv(C)*(X-M)') - 0.5*log(det(C)) + log(priorP(j));
    end
    index = find(prob==max(prob));
    colors(i,:) = color2(index,:);
end

scatter(Xs,Ys,100,colors,'filled','square');
gscatter(test_features(:,1),test_features(:,2),test_classes,color,'.',5);

hold off;