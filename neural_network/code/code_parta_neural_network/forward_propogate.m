function[z2,a2,z3,a3]= forward_propogate(X,theta1,theta2)

#runs a forward pass to find activations and z values for all layers

z2 = X * theta1';
#z2size = size(z2)
a2 = sigmoid(z2);
a2 = [ ones(size(a2,1),1), a2];
#a2size = size(a2)
z3 = a2 * theta2';
#z3size = size(z3)
a3 = (z3);

endfunction