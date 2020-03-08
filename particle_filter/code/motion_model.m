function [last_x,last_y,last_theta] = motion_model(x,y,theta,control_data)

#values at the start of the control command

x_initial = x; 
y_initial = y;
theta_initial =theta;

m= size(control_data,1);

v_var = 0.05; #variance value for control velocity
w_var = 0.05; #variance value for control angular velocity
theta_var = 0.5; #variance value to introduce noise in actual heading compared to estimated heading
 
for i=1:m-1
  
  delta_t = control_data(i+1,1) - control_data(i,1); #time delta for which the signal is given
  
  control_vel = control_data(i,2)+ sqrt(v_var) * randn; # velocity signal
  control_w = control_data(i,3)+ sqrt(w_var) * randn; # angular velocity signal
  
  #the motion model is based on instantaneous center of a circle(ICC) idea. for each time step it is assumed the robot moves in a circle
  #centered at the ICC. 
  #if angular velocity is 0, then it just moves in a straight line hence the if else statement 
  
  if( control_w == 0) # moving in a straight line
  
  new_x = x_initial + control_vel*delta_t*cos(theta_initial);
  new_y = y_initial + control_vel*delta_t*sin(theta_initial) ;
  new_theta = theta_initial;
  
  else # w >0 . Hence trajectory is a circle
  r = (control_vel/control_w); # radius of the trajectory circle
  Xc = x_initial - r * sin(theta_initial); # x value of ICC
  Yc = y_initial + r * cos(theta_initial); # y value of ICC
  
  # position of the robot at time delta_t when it follows the circular trajectory
 
 
  new_x = Xc + r * sin(theta_initial + control_w * delta_t);
  new_y = Yc - r * cos(theta_initial + control_w * delta_t) ; 
  new_theta = theta_initial + control_w * delta_t + sqrt(theta_var)*randn;
  
 
endif

  last_x = new_x;
  last_y = new_y;
  
  last_theta = new_theta;
   
  x_initial = new_x; 
  y_initial = new_y;
  theta_initial = new_theta;

endfor

endfunction
