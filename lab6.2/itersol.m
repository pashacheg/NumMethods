function x=itersol(m)
  R = zeros(m,m);
  x = ones(m, 1);
  b = ones(m, 1);
  
  for i = 1 : m
    for j = 1 : m
      R(i, j) = -1 + 2/m^2 * ((i-1)*m + j) - 1/m^2;
    endfor
  endfor
  
  A = 1/m * R - diag(ones(1,m))
  
  B = inv(diag(diag(A))) * (diag(diag(A))-A);
  c = inv(diag(diag(A))) * b;
  ep = 10^(-6);
  

  if checksol(B, m) >= 1
    return 
  endif
  
  sx = Gaus(A, b, m, 0);

  
  N = [];
  M = zeros(m, 0);
  NV = [];
  AC = [];
  
  n = 0;
  x_ = x;
  do
    x = B * x_ + c;
    
    M = [M x];
    n += 1;
    N = [N n];
    
    max_sub = 0;
    
    for i = 1 : m
      if abs(x(i) - x_(i)) > max_sub
        max_sub = abs(x(i) - x_(i));
      endif
    endfor
    
    s = A*x - b;
    nv = 0;
    for i = 1 : m
      if abs(s(i)) > nv
        nv = abs(s(i));
      endif
    endfor
    
    
    rx = 0;
    for i = 1 : m
      if abs(x(i) - sx(i)) > rx
        rx = abs(x(i) - sx(i));
      endif
    endfor
    
    NV = [NV nv];
    AC = [AC rx];
    
    x_ = x;
  until max_sub < ep
    
  
  figure(1)
  for i = 1 : m
    plot(N, M(i, :))
    hold on
  endfor
  grid on
  
  figure(2)
  semilogy(N, NV)
  hold on
  semilogy(N, AC)
  grid on
  leg = legend("residual", "precision");
  set (leg, "fontsize", 16);
  
end