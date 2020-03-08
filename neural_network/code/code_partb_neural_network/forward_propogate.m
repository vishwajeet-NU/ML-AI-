function[z2,a2,z3,a3]= forward_propogate(X,theta1,theta2)

#runs a forward pass to find activations a and z values for all layers

z2 = X * theta1';
a2 = sigmoid(z2);
a2 = [ ones(size(a2,1),1), a2];
z3 = a2 * theta2';
a3 = (z3);

endfunction