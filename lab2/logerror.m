function MAX=logerror(X,Y,n,a,b, M, draw, field)
  K = 1000;
  
  MAX = 0;
  
  F = zeros(K+1, 1); #function V23
  P = zeros(K+1, 1); #approximating polynom
  E = zeros(K+1, 1); #log errors
  
  if (!draw)
    if (!field)
      X = zeros(n+1, 1);
      Y = zeros(n+1, 1);
      for i = 0 : n
        X(i+1) = a + (b-a) / (n) * i;
        Y(i+1) = (sin(1.2*X(i+1)) + 1.7*sin(3*X(i+1))) * X(i+1); #func from V23
      endfor
    else
      X = zeros(n, 1);
      Y = zeros(n, 1);
      for i = 0 : n-1
        X(i+1) = ((-1)*cos((2*i+1)/(2*n) * pi) + 1) * 1.5;
        Y(i+1) = (sin(1.2*X(i+1)) + 1.7*sin(3*X(i+1))) * X(i+1); #func from V23
      endfor
    endif
    
  endif
  
  for i = 0 : K
    F(i+1) = (sin(1.2*M(i+1)) + 1.7*sin(3*M(i+1))) * M(i+1);
    
    if (!draw)
      if (!field)
        P(i+1) = polynom(X,Y,n+1,M(i+1));
      else
        P(i+1) = polynom(X,Y,n,M(i+1));
      endif
    else
      P(i+1) = polynom(X,Y,n,M(i+1));
    endif
    
    
    err_abs = abs(F(i+1) - P(i+1));
    
    E(i+1) = log10(err_abs);
    
    if (err_abs > MAX)
      MAX = err_abs;
    endif
  endfor
  
  
  if (draw)
    plot(M,E)
    hold on
  endif
end
