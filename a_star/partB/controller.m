#the inverse kinematic controller
function[store_x,store_y,orientation_store,x_current,y_current,theta_current,a] = controller(x_current,y_current,x_goal,y_goal,theta_current)

counter = 0;
V_old = 0; #0 starting velocity
W_old = 0;
a = 1;
v_var = 0.001; #noise variance value for control velocity
w_var = 0.001; #noise variance value for control angular velocity
theta_var = 0.01; # noise variance value to introduce noise in actual heading compared to estimated heading

while(counter==0)

[delta_t, av_max, aw_max, P_v_val, P_w_val ]=get_parameters(); #gets the control parameters

V = V_old;
W = W_old;

square_temp=sqrt((x_goal-x_current)^2 + (y_goal-y_current)^2); #linear distance to target 
V = P_v_val* square_temp;  #control velocity

delta_y= y_goal-y_current; 
delta_x= x_goal-x_current;
requiredangle = atan2(delta_y,delta_x); #required heading angle 

#converts heading angle and requiredangle to anti-clockwise angles as described in the writeup
if(requiredangle>0)
angle_anticlockwise = requiredangle;
else
angle_anticlockwise = pi+(pi- abs(requiredangle));
endif

if(theta_current >0)
theta_anticlockwise = theta_current;
else
theta_anticlockwise = pi+ (pi-abs(theta_current));
endif

angle_diff = angle_anticlockwise - theta_anticlockwise; # angular error value that needs to be corrected

W = P_w_val*(angle_diff)  ; # control angular velocity

#cuts down the increase of accln beyond the max possible values
if(((V-V_old)/0.1)>av_max)
V = V_old + av_max * 0.1;
elseif((V-V_old)/0.1<-av_max)
V =V_old -av_max * 0.1;
endif
if(((W+W_old)/0.1)>aw_max)
W = W_old+ aw_max * 0.1;
elseif(((W-W_old)/0.1)<-aw_max)
W = W_old-aw_max * 0.1;
endif

control_data = [V,W];

#gives control signal to motion model, and recieves the positions
[x_current, y_current,theta_current] = motion_model(x_current,y_current,theta_anticlockwise,control_data,v_var,w_var,theta_var);

#cuts of the controller it the robot reaches within 0.05 m of the target
if ((square_temp)<0.05 )
counter = 1;      
disp("found point")
endif

#recursive part where new velocity is given as input to next iteration
V_old = V; 
W_old = W;

store_x(a) = x_current; #stores all x co-ordinates
store_y(a) = y_current; #stores all y co-ordinates
orientation_store(a) = theta_current;

a = a + 1; #increase counter a
endwhile

endfunction
