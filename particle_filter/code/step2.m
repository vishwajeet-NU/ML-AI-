function [x_val,y_val,theta] = step2()
sample_control = [0.5,0,1;0,(-1/(2*pi)),1;0.5,0,1;0,(1/(2*pi)),1;0.5,0,1]; #datapoints mentioned in hw in time, velocity, angular velocity format

#assumuming initial position of robot to be 0 , 0 , 0
d= length(sample_control);
x_initial = 0; 
y_initial= 0;
theta_initial=0;

#variance to introduce an element of noise in control
v_var = 0.05;  #variance value for control velocity
w_var = 0.05;  #variance value for control angular velocity
theta_var = 0.5; #variance value to introduce noise in actual heading compared to estimated heading
 
for i=1:d #continue looping for all control values
  delta_t = sample_control(i,3); #time step of the signal 
  control_vel = sample_control(i,1)+ sqrt(v_var) * randn; # velocity signal 
  control_w = sample_control(i,2) + sqrt(w_var) * randn; # angular velocity signal 
  
  #the motion model is based on instantaneous center of a circle idea. for each time step it is assumed the robot moves in a circle
  #centered at the ICC. 
  #if angular velocity is 0, then it just moves in a straight line hence the if else statement 
  
  if( control_w == 0) # moving in a straight line
  new_x = x_initial + control_vel*delta_t*cos(theta_initial); 
  new_y = y_initial + control_vel*delta_t*sin(theta_initial) ;  
  new_theta = theta_initial;
  else  # w >0 . Hence trajectory is a circle
  r = (control_vel/control_w); # radius of the trajectory circle
  
  Xc = x_initial - r * cos(theta_initial); #x value of the ICC 
  Yc= y_initial - r * sin(theta_initial); # y value of the ICC
  new_x = Xc + r * cos(theta_initial + control_w * delta_t); # position of the robot at time delta_t when it follows the circular trajectory
  new_y = Yc + r * sin(theta_initial + control_w * delta_t);
  new_theta = theta_initial + control_w * delta_t + sqrt(theta_var)*randn; #final heading
  
endif
    #storing the values in a variable x_val for future use
    x_val(i) = new_x; 
    y_val(i) = new_y;
    theta(i) = new_theta;
  
    # reseting initial state to the calculated state, to calculate further motion
    x_initial = new_x; 
    y_initial = new_y;
    theta_initial = new_theta;

endfor


figure(1);

plot(x_val,y_val,"r--","markersize",6);
title('belief of x and y position to input control signal from step2 with noise, assumuming initial pos [0 0 0]');
xlabel('xpositions');
ylabel('ypositions');  
text(x_val,y_val,"location",'VerticalAlignment','bottom');



endfunction