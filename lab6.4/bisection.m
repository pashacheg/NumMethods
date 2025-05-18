function r=bisection(a, b, sw)  
  N = [];
  X = [];
  n = 0;
  
  c0 = 0;
  c1 = 0;
  c2 = 0;
  do
    c2 = (b + a)/2;
    
    if func(a) * func(c2) < 0
      b = c2;
    elseif func(b) * func(c2) < 0
      a = c2;
    elseif func(c2) == 0
      break;
    endif
    
    c0 = c1;
    c1 = c2;
    
    n += 1;
    N = [N n];
    X = [X c1];
  until (abs(c2 - c1) > abs(c1 - c0))
  if sw == 2
    plot(N,X, "-o");
    hold on;
  elseif sw == 3
    Er = [];
    R = [];
    for i = 1 : n
      res = abs(X(i) - c1);
      Er = [Er res];
      
      R = [R abs(func(X(i)))];
    endfor
    
    semilogy(N,Er, "-o");
    hold on;
    semilogy(N,R, "-o");
    hold on;
  endif
  
  r = c1;
end