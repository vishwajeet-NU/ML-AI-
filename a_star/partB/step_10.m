#plans while driving
#similar to step9, however some recursive parts of the astar code are brought here 

function step_10(figure_no)
clc
gridsize = 0.1;

S = [2.45,-3.55; 4.95, -0.05;-0.55,1.45]; # all starting positions 
G = [0.95,-1.55; 2.45, 0.25; 1.95,3.95]; # all goal positions 

x= [-2:gridsize:5]; 
y=[-6:gridsize:6];
y= -y;

for all = 1:size(S,1)
s= S(all,:);
g= G(all,:);
theta_initial = (-pi/2);

figure((figure_no), 'position',[500,80,600,900]);
title("astar grid size= 0.1, planning + p-controller, yellow = expanded nodes, pink = path, blue = controller path");
xlabel("x co-ordinates");
ylabel("y co-ordinates");

m=[];
n=[];
o=[];

m2 = [];
n2 = [];

#astar matrices defined here
current_list = [];
closed_list = [];
open_list = [];
child_list = [];

[index_s, index_g] = finding_index(x,y,s,g) #grid_start and goal locations


open_list = [open_list;index_s,0,0,0,0,0];

[gcost_grid,move_grid,open_list_tracker ] = creategrid(y,x);

while((abs(s(1) - g(1)))>0.08 || (abs(s(2) - g(2)))>0.08) #continue looping until the robot hasnt reached inside this threshold to goal
[x_path, y_path,closed_list,open_list,child_list,gcost_grid,move_grid,open_list_tracker] = astar_part_10(figure_no,s,g,closed_list,open_list,child_list,gcost_grid,move_grid,open_list_tracker);
pos1 = [s(1)		s(2)]	;
pos2 = [x_path   y_path];

theta_current = theta_initial;
x_goal = pos2(1);
y_goal = pos2(2);

[store_x, store_y, orientation_store, x_current, y_current, theta_current]=controller(pos1(1),pos1(2), x_goal, y_goal,theta_current);

m = [m;store_x']; # add the values to a storage matrix 
n = [n;store_y']; # add 
o = [o;theta_current']; # heading angles are plotted at end points instead because plotting at all positions becomes visually messy

#x and y co-ordinates for intermediate end goals
m2=[m2; x_current]; 
n2=[n2; y_current]; 

s = [x_current,y_current];
theta_initial = theta_current;

m = [x_path(1) ;m ];
n = [y_path(1);n];


endwhile

#add the starting points 
m = [x_path(1) ;m ]; 
n = [y_path(1);n];
o = [(-pi/2); o];

m2 = [x_path(1) ;m2 ]; 
n2 = [y_path(1);n2];

figure(figure_no)
plot(m,n,"b");

# used to plot heading arrows with a length of 0.2
for i =1:length(o)
r = 0.2;
u = r * cos(o(i)); 
v = r * sin(o(i));
h = quiver(m2(i),n2(i),u,v);
endfor
endfor

endfunction