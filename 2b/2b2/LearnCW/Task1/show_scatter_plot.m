apply_pca;
clf;
color = [1 0 0;0 1 0;0 0 1;1 1 0;1 0 1;0 1 1;0 0 0;0.5 0.5 0.5;0.5 0.5 0;0.5 0 0.5];
colors = zeros(10000,3);
gscatter(XPCA(:,1),XPCA(:,2),train_classes,color,'.',5);