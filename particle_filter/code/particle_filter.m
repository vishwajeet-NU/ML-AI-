function particle_filter(des)
clc
format long

disp("start of pf script")
robot_truth = load('ds1_Groundtruth.dat'); #input robot groundtruth values

#starting state of the robot from groundtruth file
x_initial = robot_truth(1,2);
y_initial = robot_truth(1,3);
theta_initial = robot_truth(1,4);

x_P_temp = []; #empty set to store x position estimate from the measurement_model
y_P_temp =[];  #empty set to store y position estimate from the measurement_model
theta_P_temp=[]; # empty set to store heading estimate from the measurement_model

alpha1 = 1; # constant to tune the variance of 'range sensor' probability 
alpha2 = 1; # constant to tune the variance of 'bearing sensor' probability

N = 1000; #number of particles in the filter 

V = 0.5; # variance of the initial estimate. The initial estimate is modeled as a gaussian around the actual position
x_P = []; #empty set to store the posterior x
y_P = []; #empty set to store the posterior y
theta_P = []; #empty set to store the posterior heading
P_w  = []; #empty set to store the weights 

#creating a distribution for the initial estimate
for i = 1:N
    x_P(i) = x_initial + sqrt(V) * randn;
    y_P(i) = y_initial + sqrt(V) * randn;
    theta_P(i) = theta_initial + sqrt(V) * randn;
endfor

[control,sensor] = give_total(); #control data and sensor values after robots in field and extra landmarks are removed

counter2 =0; #counter to store the number of iterations when control signals are non-zero

#decision loop for deciding how to execute the program based on user input
if(des == 1) 
  T = 2000;
  disp("running 2000 iterations")
else
T =size(control,1)-1;
disp("running all iterations")
endif

for k = 1:T

  if( control(k,2) >0 || control(k,3) > 0) # identifies whether a control signal is given to the robot
  counter2 = counter2 + 1; # if a control signal is provided, counter captures that increment 
  for m=1:N
  [x_P_temp(m), y_P_temp(m), theta_P_temp(m)] = motion_model(x_P(m), y_P(m), theta_P(m), control(k:k+1,:)); # motion model outputs predicted state
  
  #since there is a mismatch in sampling rates , this finds the nearest sensor reading time to the control signal
  
  index_time = find(control(k,1)>sensor(:,1)); #index of reading matching the criteria   
  index_time = index_time(length(index_time)); #actual time value
    
  [model_range(m), model_heading(m)]= measurement_model(sensor(index_time,2),x_P_temp(m),y_P_temp(m),theta_P_temp(m)); #finding the range and heading given a predicted state
  
  # the difference between actual sensor reading and predicted reading
  range_diff = sensor(index_time,3)-model_range(m); 
  heading_diff = sensor(index_time,4)-model_heading(m);

  range_var = alpha1 * sensor(index_time,3); #variance value for probability of range sensor reading
  heading_var = abs(alpha2 * sensor(index_time,4)) + rand/10; #variance value for probability of bearing sensor reading
  P_w_range(m) = (1/sqrt(2*pi*range_var)) * exp(-(((range_diff^2)/(2*range_var)))); #P(w(range)|xt)
  P_w_theta(m) = (1/sqrt(2*pi*heading_var)) * exp(-(((heading_diff^2)/(2*heading_var)))); #P(w(range)|xt)

  P_w(m) = P_w_range(m) * P_w_theta(m); # assuming conditional independence of the sensor values
  endfor
  
   P_w = P_w./sum(P_w); #normalizing the probability of each particle
   
 #resampling of each state for future prediction   
 for t =1:N
   x_P(t) = x_P_temp(find(rand <= cumsum(P_w),1));
   y_P(t) = y_P_temp(find(rand <= cumsum(P_w),1));
   theta_P(t) = theta_P_temp(find(rand <= cumsum(P_w),1));  
 endfor
    
  P_w = []; #resetting the weights 

  #mean of all particles, which estimates actual state of robot

  x_est(counter2) = mean(x_P);  
  y_est(counter2) = mean(y_P);
  theta_est(counter2) = mean(theta_P);
  
  k = k +1;

  endif

endfor

if(des==1)
figure(3)
plot(robot_truth(1:23000,2),robot_truth(1:23000,3),"b");
hold on 

plot(x_est,y_est,"r");
title("groundtruth vs filteroutput, 2000 iterations, groundtruth in blue, filter output red");
xlabel("xaxis");
ylabel("yaxis");

else
figure(3)
plot(robot_truth(:,2),robot_truth(:,3),"r");
hold on 
plot(x_est,y_est);
title("groundtruth vs filteroutput, all iterations groundtruth in blue, filter output red");
xlabel("xaxis");
ylabel("yaxis");
endif

