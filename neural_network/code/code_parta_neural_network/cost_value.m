function[cost]=  cost_value(a,y,m)
  
 cost = (sum((0.5) * (y-a).* (y-a)))/m; 

  
endfunction
