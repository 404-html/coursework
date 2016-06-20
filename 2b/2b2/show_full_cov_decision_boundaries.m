hold on;

%adjust the region intervals here
interval = 0.1;
repeats = 16 * (1/interval) +1;
totlength = repeats * repeats;
Xs = repmat(-8:interval:8,1,repeats);
Ys = reshape(repmat(-8:interval:8,repeats,1),1,totlength);
color = [1 0 0;0 1 0;0 0 1;1 1 0;1 0 1;0 1 1;0 0 0;0.5 0.5 0.5;0.5 0.5 0;0.5 0 0.5];
color2 = [1 0.5 0.5;0.75 1 0.75;0.5 0.5 1;1 1 0.5;1 0.5 1;0.5 1 1;0.5 0.5 0.5;0.75 0.75 0.75;0.75 0.75 0.5;0.75 0.5 0.75];
colors = zeros(totlength,3);

means = zeros(10,2);
covMat = zeros(2,2,10);
confMatGF = zeros(10);
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

for i = 1:totlength
    prob = zeros(1,10);
    for j = 1:10
        M = means(j,:);
        C = covMat(:,:,j);
        X = [Xs(i),Ys(i)];
        prob(j) = (1/sqrt(((2*pi)^2)*det(C))) * exp(-0.5*(X-M)*inv(C)*(X-M)');
    end
    index = find(prob==max(prob));
    colors(i,:) = color2(index,:);
end

scatter(Xs,Ys,100,colors,'filled','square');
gscatter(test_features(:,1),test_features(:,2),test_classes,color,'.',5);

hold off;