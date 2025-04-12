function X=Kholet(A, B, n, m)
  L = zeros(n,n);
  X = zeros(n,m);
  
  for i = 1 : n   
    L(i,i) = A(i,i);
    for k = 1 : i - 1
      L(i,i) -= L(i,k)^2;
    endfor
    L(i,i) = sqrt(L(i,i));
    
    for s = i+1 : n    
      L(s,i) = A(s,i);
      for k = 1 : i - 1
        L(s,i) -= L(s,k) * L(i,k);
      endfor
      L(s,i) /= L(i,i);
    endfor
    L
  endfor
  
  
  dt = 1;
  for i = 1 : n
    dt *= L(i,i);
  endfor
  dt^2
  
  Y = zeros(n,m);
  for p = 1 : m
    for i = 1 : n
      t = B(i,p);
      for k = 1 : i - 1
        t -= Y(k,p) * L(i,k);
      endfor
      Y(i,p) = t/L(i,i);
    endfor
  endfor
  
  U = L';
  for p = m : -1 : 1
    for i = n : -1 : 1
      t = Y(i,p);
      for k = i+1 : n
        t -= X(k,p) * U(i,k);
      endfor
      X(i,p) = t/U(i,i);
    endfor
  endfor
  
  T = A*X - B;
  R = 0;
  for i = 1 : n
    for j = 1 : m
      R += T(i,j)^2;
    endfor
  endfor
  R = sqrt(R)
end