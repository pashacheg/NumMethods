function X=running(M, Y, n)
  X = zeros(n,1);
  
  AL = [];
  BT = [];
  
  for i = 1 : n
    a = b = c = 0;
    al = bl = 0;
    
    b = M(i,i);
    if i == 1
      c = M(i,i+1);
    elseif i == n
      a = M(i,i-1);
      al = AL(i-1);
      bl = BT(i-1);
    else
      a = M(i,i-1);
      c = M(i,i+1);
      al = AL(i-1);
      bl = BT(i-1);
    endif
    
    AL = [AL -c/(b + a * al)];
    BT = [BT (Y(i) - a * bl)/(b + a * al)];
  endfor
  
  X(n) = BT(n);
  for i = n-1 : -1 : 1
    X(i) = AL(i) * X(i+1)  + BT(i);
  endfor
end
