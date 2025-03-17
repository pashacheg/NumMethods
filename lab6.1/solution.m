function X=solution(A, B, n)
  E = ones(1,n);
  
  B_rev = Gaus(B, diag(E), n, 1);
  nA = B_rev * A;
  
  X = Gaus(nA, diag(E), n, 1);
  
  k = intmax();
  R = A*X - B;
  
  nR = 0;
  for i = 1 : n
    for j = 1 : n
      if abs(R(i,j)) > nR
        nR = abs(R(i,j));
      endif
    endfor
  endfor
  nR
end