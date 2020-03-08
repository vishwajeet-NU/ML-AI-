function[grid1,grid2,grid3]= creategrid(y,x)
grid1 = ones( length(y)-1, length(x)-1); #creating a matrix which will show all 'g' costs 
grid2 = zeros( length(y)-1, length(x)-1); #creates matrix to track close list
grid3 = zeros( length(y)-1, length(x)-1); #creates matrix to track open list
endfunction
