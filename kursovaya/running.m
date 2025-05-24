function X=running(Y)
  X = [0 0 0 0 0]';
  M = [4 1 0 0 0; 3 6 1 0 0; 0 3 4 2 0; 0 0 1 5 3; 0 0 0 3 4];
  
  AL = [0 0 0 0 0];
  BT = [0 0 0 0 0];
  
  for i = 1 : 5
    a = b = c = 0;
    al = bl = 0;
    
    b = M(i,i);
    if i == 1
      c = M(i,i+1);
    elseif i == 5
      a = M(i,i-1);
      al = AL(i-1);
      bl = BL(i-1);
    else
      a = M(i,i-1);
      c = M(i,i+1);
      al = AL(i-1);
      bl = BL(i-1);
    endif
    
    AL(i) = -c / (b + a * al);
    BL(i) = (Y(i) - a * bl) / (b + a * al);
  endfor
  
  X(5) = BL(5);
  for i = 4 : -1 : 1
    X(i) = AL(i) * X(i+1)  + BL(i);
  endfor
end
