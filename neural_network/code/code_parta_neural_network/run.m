clear 
clc
close all

input_nodes  = 1;  #number of input nodes to neural network 
hidden_layer_size = 60;  #number of nodes in hidden layer  
output_nodes = 1;        #number of output nodes 
                        
data = load("trainsindata.csv");
X = data(:,1);
y = data(:,2);

m = size(X, 1);
J_store = [];
lambda = 0; #factor for regularization 
initial_Theta1 = randomWeights(input_nodes, hidden_layer_size); #creating a randomly initialized matrix for initial weights layer 1 - layer 2
initial_Theta2 = randomWeights(hidden_layer_size, output_nodes); #creating a randomly initialized matrix for initial weights layer 2- layer 3

counter = 1;

#parameters for 'momentum' gradient descent optimization 
alpha = 0.05; 
epsilon = 0.0000001;
mu1 = 0.2;
v1  =0;
mu2 = 0.2;
v2  =0;
disp("starting training ");
while J>0.0002 && counter < 10000 #test case : if cost is less than 0.0002 or iterations are higher


#get cost and gradients across entire training set
[J Theta1_grad Theta2_grad] = back_propogation(initial_Theta1,initial_Theta2, input_nodes, hidden_layer_size,output_nodes, X, y, lambda);
counter = counter + 1
J
J_store = [J_store;J];

#v parameter for momentum
v1 = mu1*v1 - alpha*Theta1_grad;
v2 = mu2 *v2 - alpha*Theta2_grad;

#new weight values based on the gradient
initial_Theta1 = initial_Theta1 +v1 ;
initial_Theta2 = initial_Theta2  + v2;

endwhile

disp( " training done! ") 
disp("cost is")
J

figure(2) 
x = [ones(size(X,1),1) ,X]; #adding 1's for the bias layer 
[k11,k22,k33,k44] = forward_propogate(x,initial_Theta1,initial_Theta2); #doing 1 forward pass to get estimated y values

plot(X,k33,"m");
title(" comparision plot, train y data in red, test y in yellow, fit neural train in magenta and fit test in black");
xlabel('input data');
ylabel('output data');
hold on 
plot(X,y,"r+")

hold on 

data2 = load("testdata.csv"); #loading the test case 
X_new = data2(:,1); 
n=size(X_new,1);
d = [ones(size(X_new,1),1) ,X_new];
[k1,k2,k3,k4] = forward_propogate(d,initial_Theta1,initial_Theta2); #doing 1 forward pass to get estimated y values for test case

plot(X_new, k3,"k")
hold on
plot(X_new, data2(:,2),"yd");


average_error_trainingset = cost_value(k33,y,m)
average_error_testset = cost_value(k3,data2(:,2),n)

