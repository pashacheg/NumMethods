function r=approx(X, Y, a, b, n, M) 
  K = 1000;
  
  P = zeros(K+1, 1); #approximating polynom

  for i = 0 : K
    P(i+1) = polynom(X,Y,n+1,M(i+1));
  endfor
  
  plot(M,P,"--")
  hold on
  grid on
  
end

