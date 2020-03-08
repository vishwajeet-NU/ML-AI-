function g = sigmoidGradient(z)

#derivative of sigmoid fn. It takes the simple form, g(z) * (1-g(z))
g = zeros(size(z));

sigmoid = sigmoid(z);
g = sigmoid .* (1 .- sigmoid);




end
