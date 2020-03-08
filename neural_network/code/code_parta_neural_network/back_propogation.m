function [J Theta1_gradient Theta2_gradient] = back_propogation(Theta1,Theta2,input_layer_size,hidden_layer_size,num_labels,X, y, lambda)
  
X = [ones(size(X,1),1) ,X]; #adding bias nodes
   
m = size(X, 1);
         
J = 0; #cost 
Theta1_gradient = zeros(size(Theta1)); #matrix to store partial derivatives/ gradients
Theta2_gradient = zeros(size(Theta2));

a1 = X; #no activation for input layer
a2 = [ones(m, 1) sigmoid(a1 * Theta1')]; #activation values for hidden layer
z3 = a2 * Theta2'; #z values for final layer 
a3 = z3; #no activation for final layer as its a regression problem

cost = ((0.5) * (y-a3).* (y-a3)); #mean squared cost

Theta1NoBias = Theta1(:, 2:end); #the bias layers arent regularized. Hence matrix to keep values from 2 to last
Theta2NoBias = Theta2(:, 2:end);
J = (1 / m) * sum(sum(cost)) + (lambda / (2 * m)) * (sum(sum(Theta1NoBias .^ 2)) + sum(sum(Theta2NoBias .^ 2))); #regularized cost

b_delta1 = zeros(size(Theta1)); #cummulative partial derivative storage
b_delta2 = zeros(size(Theta2));


for i = 1:m,
  # running forward propgation for each training data
	a1_i = a1(i,:)'; 
	a2_i = a2(i,:)';
  a3_i=a3(i,:)';
  
  y_i = y(i,:)'; #y value for current training data
  
	s_delta3 = a3_i - y_i; #small delta from 'back_propogation algorithm layer 3'

	z2_i = [1; Theta1 * a1_i];
	s_delta2 = Theta2' * s_delta3 .* sigmoidGradient(z2_i); #small delta from 'back_propogation algorithm' layer 2 

  
	b_delta1 = b_delta1 + s_delta2(2:end) * a1_i'; #partial derivatives of J, w.r.t weights 1
	b_delta2 = b_delta2 + s_delta3 * a2_i'; #partial derivatives of J, w.r.t weights 2
end;

Theta1ZeroBias = [ zeros(size(Theta1, 1), 1) Theta1NoBias ];
Theta2ZeroBias = [ zeros(size(Theta2, 1), 1) Theta2NoBias ];
Theta1_gradient = (1 / m) * b_delta1 + (lambda / m) * Theta1ZeroBias; #the sum is divided over all training sets
#second half of the equation is regularized part 
Theta2_gradient = (1 / m) * b_delta2 + (lambda / m) * Theta2ZeroBias;

end
