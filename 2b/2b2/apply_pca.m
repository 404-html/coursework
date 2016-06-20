[EVecs,EVals] = compute_pca(train_features);
E2 = EVecs(:,1:2);
V2 = EVals(1:2,:);
XPCA = train_features * E2;