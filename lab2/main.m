function r=main(a,b)
  K = 100;
  
  M = zeros(K, 1);
  F = zeros(K, 1); #function V23
  
  n1 = 4;
  n2 = 8;
  n3 = 10;
  
  X1 = zeros(n1, 1);
  Y1 = zeros(n1, 1);
  
  X2 = zeros(n2, 1);
  Y2 = zeros(n2, 1);
  
  X3 = zeros(n3, 1);
  Y3 = zeros(n3, 1);
  
  for i = 1 : K
    M(i) = a + (b-a) / K * i;
    F(i) = (sin(1.2*M(i)) + 1.7*sin(3*M(i))) * M(i);
  endfor
  
  for i = 1 : n1
    X1(i) = a + (b-a) / (n1 - 1) * i;
    Y1(i) = (sin(1.2*X1(i)) + 1.7*sin(3*X1(i))) * X1(i); #func from V23
  endfor
  for i = 1 : n2
    X2(i) = a + (b-a) / (n2 - 1) * i;
    Y2(i) = (sin(1.2*X2(i)) + 1.7*sin(3*X2(i))) * X2(i); #func from V23
  endfor
  for i = 1 : n3
    X3(i) = a + (b-a) / (n3 - 1) * i;
    Y3(i) = (sin(1.2*X3(i)) + 1.7*sin(3*X3(i))) * X3(i); #func from V23
  endfor  
  
  
  figure(1)
  plot(M,F)
  hold on
  approx(X1,Y1, a,b, n1, M);
  approx(X2,Y2, a,b, n2, M);
  approx(X3,Y3, a,b, n3, M);
  legend("f23", "P_4", "P_8", "P_10_", "location", "northeast")
  
  
  figure(2)
  logerror(X1,Y1, n1, a,b, M, 1);
  logerror(X2,Y2, n2, a,b, M, 1);
  logerror(X3,Y3, n3, a,b, M, 1);
  grid on
  legend("P_4", "P_8", "P_10_", "location", "northeast")
  
  N = 10;
  max_errors = zeros(N, 1);
  
  for n = 1 : N
    max_errors(n) = logerror(0,0, n, a,b, M, 0);
  endfor
  
  figure(3)
  plot(max_errors)
  grid on
  
end
