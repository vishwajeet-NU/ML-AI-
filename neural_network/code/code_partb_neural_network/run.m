clear 
clc
close all
input_nodes  = 6;  #number of input nodes to neural network 
hidden_layer_size = 30;  #number of nodes in hidden layer  
output_nodes = 4;        #number of output nodes 
                        
#loading the dataset
data = load('learning_dataset.csv');

X = data(:,1:6); #taking the X values from the dataset  
y = data(:,7:10); #taking the Y values from the dataset 

X_test = X(8001:end,:); #test dataset
y_test = y(8001:end,:); #test dataset

X= X(1:8000,:); #training dataset 
y= y(1:8000,:); 
m = size(X, 1); #number of training examples 
J_store = [];
lambda = 0; #factor for regularization 
initial_Theta1 = randomWeights(input_nodes, hidden_layer_size); #creating a randomly initialized matrix for initial weights layer 1 - layer 2
initial_Theta2 = randomWeights(hidden_layer_size, output_nodes); #creating a randomly initialized matrix for initial weights layer 2- layer 3

counter = 1;

#parameters for 'momentum' gradient descent optimization 
alpha = 0.05; #gradient descent tuner
mu1 = 0.2; 
v1  =0;
mu2 = 0.2;
v2  =0;
disp("starting training ");
while J>0.0002 && counter < 5000 #test case : if cost is less than 0.0002 or iterations are higher


#get cost and gradients across entire training set
[J Theta1_grad Theta2_grad] = back_propogation(initial_Theta1,initial_Theta2, input_nodes, hidden_layer_size,output_nodes, X, y, lambda);
counter = counter + 1
disp("cost is")
J
J_store = [J_store;J];

#v parameter for momentum
v1 = mu1*v1 + alpha*Theta1_grad;
v2 = mu2 *v2 + alpha*Theta2_grad;

#new weight values based on the gradient
initial_Theta1 = initial_Theta1 -v1 ;
initial_Theta2 = initial_Theta2 -v2;


endwhile

disp( " training done! ") 
disp("cost is")
J

figure(1) 
x = [ones(size(X,1),1) ,X]; #adding 1's for the bias layer 
[k11,k22,k33,k44] = forward_propogate(x,initial_Theta1,initial_Theta2); #doing 1 forward pass to get estimated y values

#plot for x,y co-ordinates of the training data vs the x,y actual data
plot(k33(:,1),k33(:,2),"g");
title(" comparision plot on training data: neural network prediction in green, groundtruth in red");
xlabel('X co-ordinates');
ylabel('Y co-ordinates');
hold on 
plot(y(:,1),y(:,2),"r")

#plot for sin of heading of the training data vs the actual sin of heading 
figure(2)
plot(k33(:,3),"g");
title(" comparision plot on training data: neural network prediction of sin(heading) in green, groundtruth sin(heading) in red");
xlabel('control signal number');
ylabel('sin of heading');
hold on 
plot(y(:,3),"r")

#plot for cos of heading of the training data vs the actual cos of heading 
figure(3)
plot(k33(:,4),"g");
title(" comparision plot on training data: neural network prediction of cos(heading) in green, groundtruth cos(heading) in red");
xlabel('control signal number');
ylabel('cos of heading ');
hold on 
plot(y(:,4),"r")


hold on 
figure(4)
n=size(X_test,1);
d = [ones(size(X_test,1),1) ,X_test];
[k1,k2,k3,k4] = forward_propogate(d,initial_Theta1,initial_Theta2); #doing 1 forward pass to get estimated y values for test case

#plot for x,y co-ordinates of the test data vs the x,y actual data

plot(k3(:,1), k3(:,2),"k")
title(" comparision plot on test data: neural network prediction in black, groundtruth in blue");
xlabel('X co-ordinates');
ylabel('Y co-ordinates');
hold on
plot(y_test(:,1),y_test(:,2),"b");

#plot for sin of heading of the test data vs the actual sin of heading 
figure(5)
plot(k3(:,3),"g");
title(" comparision plot on test data: neural network prediction of sin(heading) in green, groundtruth sin(heading) in red");
xlabel('control signal number');
ylabel('sin of heading');
hold on 
plot(y_test(:,3),"r")

#plot for cos of heading of the test data vs the actual cos of heading 
figure(6)
plot(k3(:,4),"g");
title(" comparision plot on test data: neural network prediction of cos(heading) in green, groundtruth cos(heading) in red");
xlabel('control signal number');
ylabel('cos of heading');
hold on 
plot(y_test(:,4),"r")


#evaluation parameters for training data 
#mse = mean square error, r2 = coefficient of determinnation 
[mse_train,r2_train] = find_fit_quality(k33,y,m);
disp("MSE values, training set are [x,y,sin(theta),cos(theta)]");
mse_train
disp("R2 values, training set are [x,y,sin(theta),cos(theta)]");
r2_train

#evaluation parameters for test data
#mse = mean square error, r2 = coefficient of determinnation 
[mse_test,r2_test] = find_fit_quality(k3,y_test,n);
disp("MSE values, test set are [x,y,sin(theta),cos(theta)]");
mse_test
disp("R2 values, test set are [x,y,sin(theta),cos(theta)]");
r2_test

