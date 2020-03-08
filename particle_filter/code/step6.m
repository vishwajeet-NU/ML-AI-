function [req_land,distance,angle_diff] = step6()

landmark= load('ds1_Landmark_Groundtruth.dat'); #importing landmark positions 

state = [2,3,0;0,3,0;1,-2,0]; # the positions of the robot mentioned in point 6

step6_land= [6,13,17]; #landmarks of interest for point 6

state_length = size(state,1); #number of positions where heading and range is to be calculated

for j=1:state_length #looping through all the positions mentioned in point 6
  
state1 = state(j,:); #co-ordinates for jth state 
req_land(j) = step6_land(j); #landmark to be located

# finding the necessary landmark from the list of landmarks imported

landmark_x = landmark(find(landmark==req_land(j)),2)  
landmark_y = landmark(find(landmark==req_land(j)),3)

diff_x = landmark_x -state(1,1) ;
diff_y = landmark_y -state(1,2);

angle(j) = atan2(diff_y, diff_x); # angle between landmark and state co-ordinates

if(angle(j)>0)
angle_clockwise(j) = angle(j);

else
angle_clockwise(j) = pi+(pi- abs(angle(j)));

endif

if(state(1,3) >0)
theta_clockwise(j) = state(1,3);
else
theta_clockwise(j) = pi+ (pi-abs(state(1,3)));
endif

angle_diff(j) = angle_clockwise(j) - theta_clockwise(j); # actual angle between the robot heading line of sight and the landmark
distance(j) = sqrt(((landmark_y - state1(1,2))^2 + (landmark_x - state1(1,1))^2)); #distance between robot and landmark
 
endfor


endfunction