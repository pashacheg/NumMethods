function r=main(a,b)
  K = 1000;
  
  M = zeros(K+1, 1);
  F = zeros(K+1, 1); #function V23
  
  n1 = 4;
  n2 = 8;
  n3 = 10;
  
  X1 = zeros(n1+1, 1);
  Y1 = zeros(n1+1, 1);
  
  X2 = zeros(n2+1, 1);
  Y2 = zeros(n2+1, 1);
  
  X3 = zeros(n3+1, 1);
  Y3 = zeros(n3+1, 1);
  #chebyshev
  X4 = zeros(n1, 1);
  Y4 = zeros(n1, 1);
  
  X5 = zeros(n2, 1);
  Y5 = zeros(n2, 1);
  
  X6 = zeros(n3, 1);
  Y6 = zeros(n3, 1);
  
  for i = 0 : K
    M(i+1) = a + (b-a) / K * i;
    F(i+1) = (sin(1.2*M(i+1)) + 1.7*sin(3*M(i+1))) * M(i+1);
  endfor
  
  for i = 0 : n1
    X1(i+1) = a + (b-a) / (n1) * i;
    Y1(i+1) = (sin(1.2*X1(i+1)) + 1.7*sin(3*X1(i+1))) * X1(i+1); #func from V23
  endfor
  for i = 0 : n2
    X2(i+1) = a + (b-a) / (n2) * i;
    Y2(i+1) = (sin(1.2*X2(i+1)) + 1.7*sin(3*X2(i+1))) * X2(i+1); #func from V23
  endfor
  for i = 0 : n3
    X3(i+1) = a + (b-a) / (n3) * i;
    Y3(i+1) = (sin(1.2*X3(i+1)) + 1.7*sin(3*X3(i+1))) * X3(i+1); #func from V23
  endfor  
  #chebyshev
  for i = 0 : n1-1
    X4(i+1) = ((-1)*cos((2*i+1)/(2*n1) * pi) + 1) * 1.5;
    Y4(i+1) = (sin(1.2*X4(i+1)) + 1.7*sin(3*X4(i+1))) * X4(i+1); #func from V23
  endfor
  for i = 0 : n2-1
    X5(i+1) = ((-1)*cos((2*i+1)/(2*n2) * pi) + 1) * 1.5;
    Y5(i+1) = (sin(1.2*X5(i+1)) + 1.7*sin(3*X5(i+1))) * X5(i+1); #func from V23
  endfor
  for i = 0 : n3-1
    X6(i+1) = ((-1)*cos((2*i+1)/(2*n3) * pi) + 1) * 1.5;
    Y6(i+1) = (sin(1.2*X6(i+1)) + 1.7*sin(3*X6(i+1))) * X6(i+1); #func from V23
  endfor  
  
  
  figure(1)
  plot(M,F)
  hold on
  approx(X1,Y1, a,b, n1+1, M);
  approx(X2,Y2, a,b, n2+1, M);
  approx(X3,Y3, a,b, n3+1, M);
  legend("func", "P_4", "P_8", "P_10_", "location", "northwest")
  
  
  figure(2)
  logerror(X1,Y1, n1+1, a,b, M, 1,0);
  logerror(X2,Y2, n2+1, a,b, M, 1,0);
  logerror(X3,Y3, n3+1, a,b, M, 1,0);
  grid on
  legend("P_4", "P_8", "P_10_", "location", "northwest")
  
  #chebyshev
  figure(4)
  plot(M,F)
  hold on
  approx(X4,Y4, a,b, n1, M);
  approx(X5,Y5, a,b, n2, M);
  approx(X6,Y6, a,b, n3, M);
  legend("func", "P_4", "P_8", "P_10_", "location", "northwest")

  
  figure(5)
  logerror(X4,Y4, n1, a,b, M, 1,1);
  logerror(X5,Y5, n2, a,b, M, 1,1);
  logerror(X6,Y6, n3, a,b, M, 1,1);
  grid on
  legend("P_4", "P_8", "P_10_", "location", "northwest")
  
  
  
  N = 50;
  max_errors = zeros(N, 1);
  
  for n = 1 : N
    max_errors(n) = log10(logerror(0,0, n, a,b, M, 0,0));
  endfor
  
  
  figure(3)
  plot(max_errors)
  grid on
  
  
  N = 50;
  max_errors = zeros(N, 1);
  
  for n = 1 : N
    max_errors(n) = log10(logerror(0,0, n, a,b, M, 0,1));
  endfor
  
  
  figure(6)
  plot(max_errors)
  grid on
  
end
