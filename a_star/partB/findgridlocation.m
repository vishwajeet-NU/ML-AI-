function[x_upper,x_lower,y_upper,y_lower] = findgridlocation(x,y,x_grid,y_grid)
  
  x_upper = x(find(x_grid<x,1)); 
  d = find(x_grid>x);
  x_lower = x(length(d));

  y_upper = y(find(y_grid>y,1));
  e = find(y_grid<y);
  y_lower = y(length(e));

 
endfunction
