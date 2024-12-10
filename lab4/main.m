function r=main(a, b)
  K = 1000;
  M = zeros(K+1, 1);
  
  F = zeros(K+1, 1);
  D1 = zeros(K+1, 1);
  D2 = zeros(K+1, 1);
  
  H = [0.1 0.05 0.025 0.01 0];

  for i = 0 : K
    M(i+1) = a + (b-a)/K * i;
    F(i+1) = func(M(i+1));
    D1(i+1) = funcd(M(i+1));
    D2(i+1) = funcdd(M(i+1));
  endfor
  
  dE1 = zeros(K+1, 1);
  dE2 = zeros(K+1, 1);
  dE3 = zeros(K+1, 1);
  dE4 = zeros(K+1, 1);
  
  ddE1 = zeros(K+1, 1);
  ddE2 = zeros(K+1, 1);
  ddE3 = zeros(K+1, 1);
  ddE4 = zeros(K+1, 1);
  
  dmax1 = -999999999;
  dmax2 = -999999999;
  dmax3 = -999999999;
  dmax4 = -999999999;
  dfmax = -999999999;
  
  ddmax1 = -999999999;
  ddmax2 = -999999999;
  ddmax3 = -999999999;
  ddmax4 = -999999999;
  ddfmax = -999999999;
  
  for i = 0 : K
    
    dapr1 = dif(M(i+1), H(1), 1);
    dapr2 = dif(M(i+1), H(2), 1);
    dapr3 = dif(M(i+1), H(3), 1);
    dapr4 = dif(M(i+1), H(4), 1);
    
    derr1 = abs(D1(i+1) - dapr1);
    derr2 = abs(D1(i+1) - dapr2);
    derr3 = abs(D1(i+1) - dapr3);
    derr4 = abs(D1(i+1) - dapr4);
    
    df = polynom(H, [dapr1 dapr2 dapr3 dapr4], 4, 0);
    
    ddapr1 = dif(M(i+1), H(1), 2);
    ddapr2 = dif(M(i+1), H(2), 2);
    ddapr3 = dif(M(i+1), H(3), 2);
    ddapr4 = dif(M(i+1), H(4), 2);
    
    dderr1 = abs(D2(i+1) - ddapr1);
    dderr2 = abs(D2(i+1) - ddapr2);
    dderr3 = abs(D2(i+1) - ddapr3);
    dderr4 = abs(D2(i+1) - ddapr4);
    
    ddf = polynom(H, [ddapr1 ddapr2 ddapr3 ddapr4], 4, 0);
    
    dE1(i+1) = log10(derr1);
    dE2(i+1) = log10(derr2);
    dE3(i+1) = log10(derr3);
    dE4(i+1) = log10(derr4);
    derror = log10(abs(D1(i+1) - df));
    
    
    ddE1(i+1) = log10(dderr1);
    ddE2(i+1) = log10(dderr2);
    ddE3(i+1) = log10(dderr3);
    ddE4(i+1) = log10(dderr4);
    dderror = log10(abs(D2(i+1) - ddf));
    
    if (dE1(i+1) > dmax1)
      dmax1 = dE1(i+1);
    endif
    if (dE2(i+1) > dmax2)
      dmax2 = dE2(i+1);
    endif
    if (dE3(i+1) > dmax3)
      dmax3 = dE3(i+1);
    endif
    if (dE4(i+1) > dmax4)
      dmax4 = dE4(i+1);
    endif
    
    if (derror > dfmax)
      dfmax = derror;
    endif
    
    
    if (ddE1(i+1) > ddmax1)
      ddmax1 = ddE1(i+1);
    endif
    if (ddE2(i+1) > ddmax2)
      ddmax2 = ddE2(i+1);
    endif
    if (ddE3(i+1) > ddmax3)
      ddmax3 = ddE3(i+1);
    endif
    if (ddE4(i+1) > ddmax4)
      ddmax4 = ddE4(i+1);
    endif
    
    if (dderror > ddfmax)
      ddfmax = dderror;
    endif
    
  endfor
  
  
  figure(1)
  plot(M,F)
  hold on
  plot(M,D1)
  hold on
  plot(M,D2)
  grid on
  leg = legend("f(x)", "f'(x)", "f''(x)");
  set (leg, "fontsize", 16);
  
  figure(2)
  plot(M, dE1)
  hold on  
  plot(M, dE2)
  hold on
  plot(M, dE3)
  hold on
  plot(M, dE4)
  grid on
  leg = legend("h=0.1","h=0.05","h=0.025","h=0.01", "location", "southeast");
  set (leg, "fontsize", 16);

 
  
  figure(3)
  plot(M, ddE1)
  hold on  
  plot(M, ddE2)
  hold on
  plot(M, ddE3)
  hold on
  plot(M, ddE4)
  grid on
  leg = legend("h=0.1","h=0.05","h=0.025","h=0.01", "location", "southeast");
  set (leg, "fontsize", 16);
  
  figure(4)
  plot(H, [dmax1 dmax2 dmax3 dmax4 dfmax])
  hold on
  plot(H, [dmax1 dmax2 dmax3 dmax4 dfmax], "rx")
  grid on
  
  figure(5)
  plot(H, [ddmax1 ddmax2 ddmax3 ddmax4 ddfmax])
  hold on
  plot(H, [ddmax1 ddmax2 ddmax3 ddmax4 ddfmax], "rx")
  grid on

end
