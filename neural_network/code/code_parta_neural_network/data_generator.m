clc
clear

#creates data for testing ml algorithm (Non linear) 

x = 0:0.008:3;
len = size(x);
ra = rand(len(1),len(2));

y =  x.^2 + exp(x)+ x + 0.1* ra;

plot(x,y,"b+")

data = [x' y'];
csvwrite("trainsindata.csv",data)
hold on 
m = 3:0.008:3.2;
len2 = size(m);
ra2 = rand(len2(1),len2(2))
n =  m.^2 + exp(m)+ m + 0.1* ra2;
plot(m,n,".r")
data2 = [m' n'];
csvwrite("testdata.csv",data2)
