function[index_s, index_g] = finding_index(x,y,s,g)
[~, s_x_lower, ~, s_y_lower] = findgridlocation(x,y,s(1),s(2)); #finding grid point cloesst to starting point
[~, g_x_lower, ~, g_y_lower] = findgridlocation(x,y,g(1),g(2)); #finding grid point cloesst to goal point

index_s= [ (find(s_y_lower ==y)), find(s_x_lower == x)];# index of starting position 
index_g= [(find(g_y_lower ==y)), find(g_x_lower == x) ]; # index of goal position 

endfunction