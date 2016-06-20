% The confusion matrix is not in the output, it's stored in respective
% confMat workspace values.
knn;
knn_100f_accuracy = sum(diag(confMat))/1000
knn2d;
knn_2f_accuracy = sum(diag(confMat2d))/1000
gaussian_full;
gaussian_full_100f_accuracy = sum(diag(confMatGF))/1000
gaussian_full_2d;
gaussian_full_2f_accuracy = sum(diag(confMatGF2d))/1000
gaussian_lda;
gaussian_lda_100f_accuracy = sum(diag(confMatGLDA))/1000
gaussian_lda_2d;
gaussian_lda_2f_accuracy = sum(diag(confMatGLDA2d))/1000