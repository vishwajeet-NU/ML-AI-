function[grid1,grid2,grid3]= creategrid(y,x)
grid1 = ones( length(y)-1, length(x)-1); #creating a grid which will show all 'g' costs 
grid2 = zeros( length(y)-1, length(x)-1); 
grid3 = zeros( length(y)-1, length(x)-1);
endfunction
