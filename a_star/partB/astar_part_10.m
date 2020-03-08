#file is almost similar to the step 6_7 file, barring paths being output to step9
#however it shares data between step10, to plan only for the next step, instead of till the final goal 
#as in step9 and earlier
function [x_path, y_path,closed_list,open_list,child_list,gcost_grid,move_grid,open_list_tracker] = astar_part_10(figure_no,s,g,closed_list,open_list,child_list,gcost_grid,move_grid,open_list_tracker )

disp("running new A* search")
gridsize = 0.1;
#Grid co-ordinates
x= [-2:gridsize:5]; 
y=[-6:gridsize:6];
y= -y;

[landmark_x_upper,landmark_x_lower,landmark_y_upper,landmark_y_lower,landmark_x_lim,landmark_y_lim ...
landmark_midpoint_x,landmark_midpoint_y,x,y,landmark_x,landmark_y ] = common_part(gridsize);


for i = 1:length(landmark_x_lim)
 
 index(i,:)= [(find(landmark_y_lim(i,1) ==y)), (find(landmark_x_lim(i,1) == x))]; # giving a grid index for location of landmarks 
 for k=-3:3
 for j = -3:3
 gcost_grid( (index(i,1)+k), (index(i,2)+j) ) = 1000;

endfor
endfor
endfor

for i = 1:length(landmark_x)
vertices = [ landmark_x_lower(i) - 0.3, landmark_y_lower(i) - 0.3; landmark_x_upper(i) + 0.3, landmark_y_lower(i) - 0.3; landmark_x_upper(i) + 0.3, landmark_y_upper(i) + 0.3;landmark_x_lower(i) - 0.3, landmark_y_upper(i) + 0.3 ];
hold on 
fill(vertices(:,1), vertices(:,2),"k");
hold on
endfor
plotinitialpoints(s,g); #plots initial positions and labels them

[index_s, index_g] = finding_index(x,y,s,g); #grid_start and goal locations

[~,idx] = sort(open_list(:,5));
open_list = open_list(idx,:);
current_list = open_list(1,:);
open_list(1,:) = [];
closed_list = [closed_list ; current_list];
open_list = [];
for i=1:size(closed_list,1)
move_grid(closed_list(i,1), closed_list(i,2)) = 1;
endfor
 
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
dim =size(closed_list,1);
path = [closed_list(dim,1), closed_list(dim,2)];
[x_path,y_path]= plot_rest2(path,s,landmark_midpoint_x,landmark_midpoint_y,gridsize);
endfunction
