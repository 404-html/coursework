hold on;
%adjust the value of K here
K = 1;
nn = zeros(1,K);
%adjust the region intervals here
interval = 0.1;
repeats = 16 * (1/interval) +1;
totlength = repeats * repeats;
X = repmat(-8:interval:8,1,repeats);
Y = reshape(repmat(-8:interval:8,repeats,1),1,totlength);
color = [1 0 0;0 1 0;0 0 1;1 1 0;1 0 1;0 1 1;0 0 0;0.5 0.5 0.5;0.5 0.5 0;0.5 0 0.5];
color2 = [1 0.5 0.5;0.75 1 0.75;0.5 0.5 1;1 1 0.5;1 0.5 1;0.5 1 1;0.5 0.5 0.5;0.75 0.75 0.75;0.75 0.75 0.5;0.75 0.5 0.75];
colors = zeros(totlength,3);
for i=1:totlength
    sqdist = sum(bsxfun(@minus,train_features(:,1:2),[X(i),Y(i)]).^2,2);
    for k = 1:K
        index = find(sqdist == min(sqdist));
        nn(k) = train_classes(index);
        sqdist(index) = [];
    end
    nnelem = unique(nn);
    nnelemfreq = histc(nn,nnelem);
    for j = 1:(size(nnelem,2))
        if nnelemfreq(j) < max(nnelemfreq)
            nn(nn==nnelem(j)) = [];
        end
    end
    mode = nn(1);
    colors(i,:) = color2(mode,:);
end
scatter(X,Y,100,colors,'filled','square');
gscatter(test_features(:,1),test_features(:,2),test_classes,color,'.',5);
hold off;