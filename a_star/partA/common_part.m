#initial conditions for all cases
function[landmark_x_upper,landmark_x_lower,landmark_y_upper,landmark_y_lower,landmark_x_lim,landmark_y_lim ...
landmark_midpoint_x,landmark_midpoint_y,x,y,landmark_x,landmark_y] = common_part(gridsize)
#Grid co-ordinates
x= [-2:gridsize:5]; 
y=[-6:gridsize:6];
y= -y;

landmarks = load('ds1_Landmark_Groundtruth.dat'); #loading obstacles
landmark_x = landmarks(:,2); # x co-ordinates of all landmarks 
landmark_y = landmarks(:,3); # y co-ordinates of all landmarks 

#converts landmarks from co-ordiantes to the cloesst grid location limits 
for i=1:length(landmark_x)
[landmark_x_upper(i),landmark_x_lower(i),landmark_y_upper(i),landmark_y_lower(i)] = findgridlocation(x,y,landmark_x(i),landmark_y(i));
endfor

landmark_x_lim= [landmark_x_lower',landmark_x_upper']; #matrix with closest x endpoints to landmark x
landmark_y_lim= [landmark_y_lower',landmark_y_upper']; #matrix with closest y endpoints to landmark y 

for o=1:length(landmark_x_lim)
landmark_midpoint_x(o) = mean(landmark_x_lim(o,:)); #middle point of x of the 1 X 1 cell containing the landmark( useful for plotting ) 
landmark_midpoint_y(o) = mean(landmark_y_lim(o,:)); #middle point of y of the 1 X 1 cell containing the landmark 
endfor 

endfunction