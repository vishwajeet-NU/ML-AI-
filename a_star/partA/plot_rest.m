function[x_path,y_path]= plot_rest(path,s,landmark_midpoint_x,landmark_midpoint_y,gridsize)

#find co-ordinates from the path in grid format
for k=1:length(path)
x_path(k) = -2 + (gridsize*path(k,2)) - (gridsize/2);
y_path(k) = 6 - (gridsize*path(k,1)) + (gridsize/2);

endfor 

#plots all the landmarks 
plot(landmark_midpoint_x,landmark_midpoint_y, "bo"); #plotting landmarks
text(landmark_midpoint_x+(gridsize/2),landmark_midpoint_y+(gridsize/2),"L");
hold on

#marks current grid
for i = 1:length(x_path)

vertices = [ x_path(i) - 0.05, y_path(i) - 0.05; x_path(i) + 0.05, y_path(i) - 0.05; x_path(i) + 0.05, y_path(i) + 0.05;x_path(i) - 0.05, y_path(i) + 0.05];
hold on 
fill(vertices(:,1), vertices(:,2),"y");
hold on
endfor

plot(x_path,y_path,"m"); #plotting the path


set(gca,'ytick',[-6:6])
set(gca,'xtick',[-2:5])
grid
endfunction
