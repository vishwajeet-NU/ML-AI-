# basic motion model to find new locations based on velocity inputs
function [new_x,new_y,new_theta] = motion_model(x,y,theta,control_data,v_var,w_var,theta_var)

#values at the start of the control command

x_initial = x; 
y_initial = y;
theta_initial =theta;

 
delta_t = 0.1; 
 
control_vel = control_data(1)+ sqrt(v_var) * randn; # velocity signal
control_w = control_data(2)+ sqrt(w_var) * randn; # angular velocity signal
  
  new_x = x_initial + control_vel*delta_t*cos(theta_initial);
  new_y = y_initial + control_vel*delta_t*sin(theta_initial) ;
  new_theta = theta_initial + control_w * delta_t + sqrt(theta_var)*randn;

endfunction
