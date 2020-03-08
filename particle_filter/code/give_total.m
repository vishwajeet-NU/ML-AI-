function [odo,measure] = give_total()


odo = load('ds1_Odometry.dat'); 
measure= load('ds1_Measurement.dat');

robots = [5,14,32,23]; # Ids of robots moving in the field. We remove those robots from our data as they arent fixed landmarks

#removing all robots from the dataset
for j=1:length(robots)
 rows= length(measure);
 rem = find(measure == robots(j));
 measure((rem-rows),:) = [];
endfor

#at various time steps in the data, there are two/ three landmarks that are identified. This removes those extra readings as only 1
#landmark is sufficient to find p(W|xt)

[~,uni_index] = unique(measure(:,1));

measure = measure(uni_index,:);
  
endfunction
