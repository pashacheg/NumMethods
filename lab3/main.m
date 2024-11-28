function r=main(a, b)
  K = 100;
  
  M = zeros(K+1, 1);
  F = zeros(K+1, 1);
  
  h1 = 0.1;
  h2 = 0.05;
  h3 = 0.025;
  h4 = 0.01;
  
  for i = 0 : K
    M(i+1) = a + (b-a)/K * i;
    F(i+1) = func23(M(i+1));
  endfor
  
  integr(a,b, h1)
  #romberg(a,b, h1)
  integr(a,b, h2)
  integr(a,b, h3)
  integr(a,b, h4)
  
  figure(1)
  plot(M, F)
  grid on
  
end
