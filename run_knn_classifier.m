function [Ypreds] = run_knn_classifier(Xtrain, Ytrain, Xtest, Ks)
% Input:
%   Xtrain : M-by-D training data matrix (double)
%   Ytrain : M-by-1 label vector (uint8) for Xtrain
%   Xtest  : N-by-D test data matrix (double)
%   Ks     : 1-by-L vector (integer) of the numbers of nearest neighbours in Xtrain
% Output:
%   Ypreds : N-by-L matrix (uint8) of predicted labels for Xtest

    [M, D] = size(Xtrain);
    [N, D] = size(Xtest);
    [~, L] = size(Ks);

    % Initialise Ypreds
    Ypreds = zeros(N, L);
    
    % Compute the square distances between each element in Xtrain and Xtest
    % bsxfun(@plus, dot(U,U,2), dot(V,V,2)')-2*(U*V');
    % SqDists = bsxfun(@plus, dot(Xtrain,Xtrain,2), dot(Xtest,Xtest,2)')-2*(Xtrain*Xtest');
    SqDists = MySqDist(Xtrain, Xtest);
    

    % Sort SqDists
    [~, idx] = sort(SqDists, 1, 'ascend');
    
    % Iterate through all the k in Ks to classify them
    for i = 1:length(Ks)
        % Get the value of k
        k = Ks(i);
        
        % Keep the first Knn indexes
        k_idx = idx(1:k, :);
        Ypreds(:,i) = mode(Ytrain(k_idx),1);
        if k==1
            Ypreds(:,i) = Ytrain(k_idx);
        end
        
    end
    
        
end
