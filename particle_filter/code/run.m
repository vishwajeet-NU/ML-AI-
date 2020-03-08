clc
clear all
format long

disp("Please enter 1 if you want to execute Part A of assignment, or press 0 for Part B")
decision_1 = input("enter the number \n");

if(decision_1 == 1)

disp("starting to execute step 2\n")
[x,y,theta] = step2(); # call to function which executes point 2


printf("x=%f \t",x) # prints x values of the robot in response to command signal in point 2
printf("\n")
printf("y=%f \t",y) # prints y values of the robot in response to command signal in point 2
printf("\n")
printf("theta=%f " ,theta) # prints theta values of the robot in response to command signal in point 2
printf("\n")


disp("\nplease press enter to continue\n")
pause


[x_1,y_1,theta_1,time] = step3(); # calls the script to plot the dead reckoned path
disp("dead-reckoned plot done\n")

disp("please press enter to continue\n")
pause


disp("land mark values with range and heading are \n")

[landmark, range, heading] = step6(); #calls the script to predict range and heading

#fprintf("landmark = %f \t range= %f \t heading= %f \n",landmark,range,heading)

printf("landmark = %f \t",landmark) #landmark number 
printf("\n")
printf("range = %f \t",range) #range to that landmark in meters
printf("\n")
printf("heading = %f \t" ,heading) #heading to that landmark in radians 
printf("\n")

pause

endif

disp("\nthe particle filter for all control singals takes more than 2 hours to run\n " );
disp("the image files have been saved in the folder \n");
disp("Please press 1 to run the particle filter for first 2000 control iterations, or press 0 for implementing it on all data \n");

decision_2 = input("enter your choice 1/0 \n");
particle_filter(decision_2)
