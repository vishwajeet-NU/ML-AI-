function[x_path,y_path]= plot_rest2(path,s,landmark_midpoint_x,landmark_midpoint_y,gridsize)
#size(path,1)
x_path = -2 + (gridsize*path(1,2)) - (gridsize/2);
y_path = 6 - (gridsize*path(1,1)) + (gridsize/2);


for i = 1:length(x_path)

vertices = [ x_path(i) - (gridsize/2), y_path(i) - (gridsize/2); x_path(i) + (gridsize/2), y_path(i) - (gridsize/2); x_path(i) + (gridsize/2), y_path(i) + (gridsize/2);x_path(i) - (gridsize/2), y_path(i) + (gridsize/2)];
hold on 
fill(vertices(:,1), vertices(:,2),"y");
hold on
endfor
plot(landmark_midpoint_x,landmark_midpoint_y, "bo"); #plotting landmarks
text(landmark_midpoint_x+(gridsize/2),landmark_midpoint_y+(gridsize/2),"L");
hold on

set(gca,'ytick',[-6:6])
set(gca,'xtick',[-2:5])
grid
endfunction
