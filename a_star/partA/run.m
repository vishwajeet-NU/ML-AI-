clc
clear
close all

step_3(1)

[sel, ok] = listdlg ("ListString", {"proceed wihtout closing plots", "close current plots and proceed"},
                     "SelectionMode", "Single");

if (ok == 1)
  if(sel ==1)
step_4_to_5(2);
 else
  
close all
pause(1)
step_4_to_5(2);
endif
endif


[sel, ok] = listdlg ("ListString", {"proceed wihtout closing plots", "close current plots and proceed"},
                     "SelectionMode", "Single");
if (ok == 1)
  if(sel ==1)
step_6_to_7(3);
  else
  
close all

pause(1)
step_6_to_7(3);
endif
endif

