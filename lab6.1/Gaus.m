function x=Gaus(A, b, n, r)
  D = [A,b];
  if r == 1
    x = zeros(n,n);
  else
    x = zeros(n,1);  
  endif

  for i = 1 : n
    q = D(i,i);
    
    if q == 0
      for j = i : n
        if D(j,i) != 0
          S = D(j,:);
          D(j,:) = D(i,:);
          D(i,:) = S;
          q = D(i,i);
          D
          break;
        endif
      endfor
      if q == 0
        continue;
      endif
    endif
    
    for j = i+1 : n
      k = D(j,i) / q;
      
      D(j,:) -= k*D(i,:);
      D
    endfor    
  endfor
  
  ######
  
  for i = n : -1 : 1    
    for j = 1 : i - 1
      if D(i,j) != 0
        return;
      endif
    endfor
    
    if D(i,i) == 0
      return;
    endif
  endfor
  
  
  for i = 1 : n
    D(i,:) /= D(i,i);
  endfor
  D
  for i = n : -1 : 1
    for j = i-1 : -1 : 1
      D(j,:) -= D(i,:) * D(j,i);
      D
    endfor
  endfor
  
  if r == 1
     for i = n + 1 : 2*n
      x(:, i-n) = D(:, i);
    endfor
  else
    x = D(:,n+1);
    
    R = A*x - b;
    nR = 0;
    
    for i = 1 : n
      if abs(R(i)) > nR
        nR = abs(R(i));
      endif
    endfor
    
    nR
  endif
  
end