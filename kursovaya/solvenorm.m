function r=solvenorm(A, n, q)
  r = 0;
  
  if q == 0
    for i = 1 : n
      r += abs(A(i));
    endfor
   elseif q == 1
    for j = 1 : n
      s = 0;
      for i = 1 : n
        s += abs(A(i,j));
      endfor
      if s > r
        r = s;
      endif
    endfor
  endif
end
