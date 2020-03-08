function[mse,r2]=  find_fit_quality(a,y,number)
 
 #finds the quality of the fit using the MSE and R^2 values 
 mse = sum(((a-y).^2))/number; #mse value 
 y_mean = mean(y); #average of y values
 SSt= sum((y-y_mean).^2); #total sum of squares 
 SSres=   sum((a-y).^2); #residual sum of squares
 r2 =  1 - SSres./SSt;  #r2 value
endfunction
