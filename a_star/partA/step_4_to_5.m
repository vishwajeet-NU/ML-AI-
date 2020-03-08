function step_4_to_5(figure_no)
#most of the code is common to step 3
clc

disp("starting first part now")
gridsize = 1;
[landmark_x_upper,landmark_x_lower,landmark_y_upper,landmark_y_lower,landmark_x_lim,landmark_y_lim ...
landmark_midpoint_x,landmark_midpoint_y,x,y,landmark_x,landmark_y ] = common_part(gridsize);

S = [0.5, -1.5; 4.5, 3.5;-0.5,5.5]; # all starting positions 
G = [0.5 , 1.5; 4.5, -1.5; 1.5,-3.5]; # all goal positions 

for( all=1:size(S,1)) #loop to go through all starting and goal positions 
[gcost_grid,move_grid,open_list_tracker ] = creategrid(y,x);

prior = [];
current_list = [];
closed_list = [];
open_list = [];
child_list = [];

for i = 1:length(landmark_x_lim)
  index(i,:)= [find(landmark_y_lim(i,1) ==y),find(landmark_x_lim(i,1) == x)]; # finding a grid index for location of landmarks 
  gcost_grid(index(i,1), index(i,2)) = 1000; # giving cost of 1000 to the landmarks( was not given in step 2)
endfor

s = [S(all,1),S(all,2)]; #starting point for current case 
g= [G(all,1), G(all,2)]; #goal point for current case


figure((figure_no), 'position',[500,80,600,900]);
title("astar grid size= 1, online verion without knowing landmarks, black squares = landmarks pink = path");
xlabel("x co-ordinates");
ylabel("y co-ordinates");

#used to mark grids with landmarks 
for i = 1:length(landmark_x)
vertices = [ landmark_x_lower(i), landmark_y_lower(i); landmark_x_upper(i), landmark_y_lower(i); landmark_x_upper(i), landmark_y_upper(i);landmark_x_lower(i), landmark_y_upper(i) ];
hold on 
fill(vertices(:,1), vertices(:,2),"k");
hold on
endfor

plotinitialpoints(s,g); #plots initial positions and labels them

[index_s, index_g] = finding_index(x,y,s,g); #grid_start and goal locations

open_list = [open_list;index_s,0,0,0,0,0];
kill = 0;

while(length(open_list) > 0 || kill == 0)

[~,idx] = sort(open_list(:,5));
open_list = open_list(idx,:);

current_list = open_list(1,:);
open_list(1,:) = [];
closed_list = [closed_list ; current_list];
#the line below makes the major change to this algorithm compared to earlier verion
open_list = [];
for i=1:size(closed_list,1)
move_grid(closed_list(i,1), closed_list(i,2)) = 1;
endfor
 
 if (current_list(1,1) == index_g(1,1) && current_list(1,2) == index_g(1,2)) 
 kill = 1;
 break
endif

[m_x,m_y] = giveneighboringcells(current_list, length(y)-1, length(x)-1);
for k= 1:length(m_x)
for j=1:length(m_y)
    
if(move_grid(m_y(j),m_x(k)) == 1)

else    
h = (sqrt( (m_y(j) - index_g(1,1))^2 + (m_x(k) - index_g(1,2))^2)-1); 

gcost = current_list(1,3) + gcost_grid(m_y(j),m_x(k));
f = h + gcost;
child_list = [child_list; m_y(j) m_x(k) gcost h f current_list(1,1) current_list(1,2) ];
  
endif  
endfor
endfor  


for po=1:size(open_list,1)
  open_list_tracker(open_list(po,1),open_list(po,2)) = 1;
endfor

for k = 1:size(child_list,1)
 if(open_list_tracker(child_list(k,1),child_list(k,2)) == 1)
 idlist = find(open_list(:,1) == child_list(k,1));
 for lo=1:length(idlist)
   if(open_list(idlist(lo),2) == child_list(k,2))
     if(child_list(k,3) <= open_list(idlist(lo), 3))
    open_list(idlist(lo),:) = child_list(k,:);
  endif 
 endif
endfor

 else
  open_list = [open_list; child_list(k,:)];
endif
endfor

child_list = [];
endwhile
path = [closed_list(:,1), closed_list(:,2)]
plot_rest(path,s,landmark_midpoint_x,landmark_midpoint_y,gridsize);

endfor

endfunction