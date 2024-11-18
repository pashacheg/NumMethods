function MAX=logerror(X,Y,n,a,b, M, draw)
  K = 100;
  
  MAX = 0;
  
  F = zeros(K, 1); #function V23
  P = zeros(K, 1); #approximating polynom
  E = zeros(K, 1); #log errors
  
  if (!draw)
    X = zeros(n, 1);
    Y = zeros(n, 1);
    
    for i = 1 : n
      X(i) = a + (b-a) / (n - 1) * i;
      Y(i) = (sin(1.2*X(i)) + 1.7*sin(3*X(i))) * X(i); #func from V23
    endfor
  endif
  
  for i = 1 : K
    F(i) = (sin(1.2*M(i)) + 1.7*sin(3*M(i))) * M(i);
    P(i) = polynom(X,Y,n,M(i));
    
    E(i) = log(abs(F(i) - P(i)));
    
    if (E(i) > MAX)
      MAX = E(i);
    endif
  endfor
  
  if (draw)
    plot(M,E)
    hold on
  endif
end
