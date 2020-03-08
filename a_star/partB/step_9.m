function step_9(figure_no)
clc
S = [2.45, -3.55; 4.95, -0.05;-0.55,1.45]; # all starting positions 
G = [0.95 , -1.55; 2.45, 0.25; 1.95,3.95]; # all goal positions 

for( all=1:size(S,1)) #loop to go through all starting and goal positions 
[x_path, y_path] = astar_part_9(figure_no,S(all,:),G(all,:)); #run the astar and get the path

pos1 = [x_path(1)		y_path(1)]; #start position from the astar

#storage matrices
m=[];
n=[];
o=[];

m2 = [];
n2 = [];
for i=1:(length(x_path)-1) #loop for all the path values
 
pos2 = [x_path(i+1)		y_path(i+1)]; #intermediate goal value for the controller 
theta_initial = (-pi/2); #initial heading 
delta_t = 0.1; 

theta_current = theta_initial;
x_goal = pos2(1);
y_goal = pos2(2);

# run the controller. Store gives all the path co-ordinates from the controller and orientation_store all the heading angles
[store_x, store_y, orientation_store, x_current, y_current, theta_current]=controller(pos1(1),pos1(2),x_goal,y_goal,theta_current);

m = [m;store_x']; # add the values to a storage matrix 
n = [n;store_y']; # add 
o = [o;theta_current']; # heading angles are plotted at end points instead because plotting at all positions becomes visually messy

#x and y co-ordinates for intermediate end goals
m2=[m2; x_current]; 
n2=[n2; y_current]; 
#update the intermediate goal as the new start position 
pos1(1) = x_current; 
pos1(2) = y_current;
theta_initial = theta_current;

endfor

#add the starting points 
m = [x_path(1) ;m ]; 
n = [y_path(1);n];

m2 = [x_path(1) ;m2 ]; 
n2 = [y_path(1);n2];

figure(1)
plot(m,n,"b");
o = [(-pi/2); o];

# used to plot heading arrows with a length of 0.2
for i =1:length(o)
r = 0.2;
u = r * cos(o(i)); 
v = r * sin(o(i));
h = quiver(m2(i),n2(i),u,v);
endfor
endfor

endfunction