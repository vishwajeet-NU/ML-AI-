clc
clear
close all

step_9(1)

[sel, ok] = listdlg ("ListString", {"proceed wihtout closing plots", "close current plots and proceed"},
                     "SelectionMode", "Single");

if (ok == 1)
  if(sel ==1)
step_10(2);
 else
  
close all
pause(1)
step_10(2);
endif
endif


[sel, ok] = listdlg ("ListString", {"proceed wihtout closing plots", "close current plots and proceed"},
                     "SelectionMode", "Single");
if (ok == 1)
  if(sel ==1)
step_11_1(3);
  else
  
close all
pause(1)
step_11_1(3);
endif
endif

[sel, ok] = listdlg ("ListString", {"proceed wihtout closing plots", "close current plots and proceed"},
                     "SelectionMode", "Single");
if (ok == 1)
  if(sel ==1)
step_11_2(4);
  else
  
close all
pause(1)
step_11_2(4);
endif
endif
