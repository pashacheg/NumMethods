function r=main(a, b)
  K = 100;

  M = zeros(K+1, 1);
  F = zeros(K+1, 1);
  
  H = [0.1 0.05 0.025 0.01 0];
  S = zeros(4, 1);
  E = zeros(5, 1);

  
  for i = 0 : K
    M(i+1) = a + (b-a)/K * i;
    F(i+1) = func23(M(i+1));
  endfor
  
  S(1) = integr(a,b, H(1));
  S(2) = integr(a,b, H(2));
  S(3) = integr(a,b, H(3));
  S(4) = integr(a,b, H(4))
  
  I = polynom(H,S, 4, 0)
  II = 0.4337808304830272
  for i = 1 : 4
    E(i) = log10(abs(II - S(i)));
  endfor
  
  E(5) = log10(abs(II - I))
  
  figure(1)
  plot(M, F)
  grid on
  legend("y = th(x), 0 < x < 1", "location", "northwest")
  
  figure(2)
  plot(H, E)
  hold on
  plot(H, E, "rx")
  grid on
  
  
end
