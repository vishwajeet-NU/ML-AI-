function g = sigmoid(z)
  # standard 'sigmoid' activation function
g = 1.0 ./ (1.0 + exp(-z));
end
