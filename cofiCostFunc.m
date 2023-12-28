function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

            
% The project should return the following values correctly
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));


% Overview: Cost function and gradient for collaborative
%               filtering. The project should first implement the cost
%               function, without regularization, and make sure it
%               matches the costs. After that, the project should implement the 
%               gradient and use the checkCostFunction routine to check
%               that the gradient is correct. Finally, the project will implement
%               the regularization.
%
% Notes: X - num_movies  x num_features matrix of movie features
%        Theta - num_users  x num_features matrix of user features
%        Y - num_movies x num_users matrix of user ratings of movies
%        R - num_movies x num_users matrix, where R(i, j) = 1 if the 
%            i-th movie was rated by the j-th user
%
%         The  variables correctly:
%
%        X_grad - num_movies x num_features matrix, containing the 
%                 partial derivatives w.r.t. to each element of X
%        Theta_grad - num_users x num_features matrix, containing the 
%                     partial derivatives w.r.t. to each element of Theta
%


% ====================== Code ======================

J= sum(((X * Theta' .- Y) .^ 2 .* R)(:)) / 2 + (sum((Theta .^ 2)(:)) + sum((X .^2)(:))) / 2 * lambda;

X_grad = (X * Theta' .- Y) .* R * Theta + lambda * X;
Theta_grad = ((X * Theta' .- Y) .* R)' * X + lambda * Theta;



grad = [X_grad(:); Theta_grad(:)];

end
