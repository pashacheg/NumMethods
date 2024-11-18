function r=approx(X, Y, a, b, n, M) 
  K = 100;
  
  P = zeros(K, 1); #approximating polynom

  for i = 1 : K
    P(i) = polynom(X,Y,n,M(i));
  endfor
  
  plot(M,P)
  hold on
  grid on
  
end

