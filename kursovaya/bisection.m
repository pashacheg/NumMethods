function r=bisection(a, b, h)
  M = web(a, b, h);
  S = size(M)(1);
  r = zeros(1,S);
  
  epsilon = 10^(-10);
  
  for i = 1 : S
    a1 = M(i,1);
    b1 = M(i,2);
    
    R = [];
    N = [];
    n = 0;
    
    while (b1 - a1 > epsilon)
      c = (b1 + a1)/2;
      
      n += 1;
      R = [R c];
      N = [N n];
      
      if func(a1) * func(c) < 0
        b1 = c;
      elseif func(b1) * func(c) < 0
        a1 = c;
      endif
    endwhile
    
    figure(i)
    plot(N,R,"-o");
    grid on
    r(i) = (b1 + a1)/2;
  endfor
  
end