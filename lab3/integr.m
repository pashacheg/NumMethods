function S=integr(a,b, h)
  S = 0;
  
  K = (b-a) / h;
  F = zeros(K+1, 1);
  
  for i = 0 : K
    x = a + (b-a)/K * i;
    F(i+1) = func23(x);
  endfor
  
  for i = 2 : 2 : K
    S+=4*F(i);
  endfor

  
  for i = 3 : 2 : K-1
    S+=2*F(i);
  endfor

  
  S += F(1) + F(K+1);
  S *= h / 3;
end
