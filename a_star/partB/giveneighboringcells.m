function[m_x,m_y] = giveneighboringcells(index_s, y_len, x_len)

if(index_s(2) == x_len )
m_y = (index_s(1) - 1) :  (index_s(1) + 1); #the neighboring cells in x to starting position
m_x = (index_s(2) - 1) :  (index_s(2)); # the neighboring cells in y to starting position

elseif(index_s(2) == 1 )
m_y = (index_s(1)) -1  :  (index_s(1)+1); #the neighboring cells in x to starting position
m_x = (index_s(2)) :  (index_s(2)+1); # the neighboring cells in y to starting position

elseif(index_s(1) == y_len )
m_y = (index_s(1) -1) :  (index_s(1)); #the neighboring cells in x to starting position
m_x = (index_s(2) - 1) :  (index_s(2)+ 1); # the neighboring cells in y to starting position


elseif(index_s(1) == 1)
m_y = (index_s(1)) :  (index_s(1) + 1); #the neighboring cells in x to starting position
m_x = (index_s(2) - 1) :  (index_s(2) + 1); # the neighboring cells in y to starting position

else
m_y = (index_s(1) - 1) :  (index_s(1)+1); #the neighboring cells in x to starting position
m_x = (index_s(2) - 1) :  (index_s(2)+1); # the neighboring cells in y to starting position

endif 
