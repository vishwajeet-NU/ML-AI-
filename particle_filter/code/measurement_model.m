function [distance,angle_diff] = measurement_model(id,x,y,theta)

landmark= load('ds1_Landmark_Groundtruth.dat'); #importing landmark positions 
barcode = load('ds1_Barcodes.dat');

#mapping barcodes to subject ids for identification
barcode = [barcode(:,2),barcode(:,1)];
land_id = barcode(find(barcode == id,1),2);
x_landmark = landmark(find(landmark==land_id),2); 
y_landmark = landmark(find(landmark==land_id),3);

#let us shift origin to the robots positions
# if xlandmark> x , then its to the right of the robot and otherwise to the left
# if ylandmark > y, then its up from the robot otherwise down

diff_x = x_landmark -x; 
diff_y = y_landmark -y;

angle = atan2((diff_y),(diff_x)); # angle between landmark and state co-ordinates

#this loop helps find the angle between robot heading and landmark according to the right-hand rule  
if(angle>0)
angle_anticlockwise = angle;

else
angle_anticlockwise = pi+(pi- abs(angle));
endif

if(theta >0)
theta_anticlockwise = theta;
else
theta_anticlockwise = pi+ (pi-abs(theta));
endif


angle_diff = angle_anticlockwise - theta_anticlockwise; # actual angle between the robot heading line of sight and the landmark
distance = sqrt(((y_landmark - y)^2 + (x_landmark - x)^2)); #distance between robot and landmark
 
endfunction


