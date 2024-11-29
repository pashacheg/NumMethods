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
  
  
  figure(1)
  plot(M,F)
  hold on
  approx(X1,Y1, a,b, n1, M);
  approx(X2,Y2, a,b, n2, M);
  approx(X3,Y3, a,b, n3, M);
  legend("func", "P_4", "P_8", "P_10_", "location", "northwest")
  
  
  figure(2)
  logerror(X1,Y1, n1, a,b, M, 1);
  logerror(X2,Y2, n2, a,b, M, 1);
  logerror(X3,Y3, n3, a,b, M, 1);
  grid on
  legend("P_4", "P_8", "P_10_", "location", "northwest")
  
  N = 50;
  max_errors = zeros(N, 1);
  
  for n = 1 : N
    max_errors(n) = log10(logerror(0,0, n, a,b, M, 0));
  endfor
  
  
  figure(3)
  plot(max_errors)
  grid on
  
end
