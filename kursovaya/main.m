function r=main()
  a = 0;
  b = 5;
  h = 0.01;
  
  epsilon = 10^(-10);
  
  R = bisection(a,b,h);
  "extremuls"
  R
  
  W = [a R b];
  M = [4 1 0 0 0; 3 6 1 0 0; 0 3 4 2 0; 0 0 1 5 3; 0 0 0 3 4];
  
  X = running(M,W, 5);
  "results"
  X  
  
  E = ones(1,5);
  RM = JordGaus(M,diag(E), 5, 1)
  
  cM = solvenorm(M,5, 1) * solvenorm(RM,5, 1)
  
  prErr = cM * solvenorm(X,5, 0) * epsilon / solvenorm(W,5, 0)
end
