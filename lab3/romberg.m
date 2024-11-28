function I=romberg(a,b, h)
  n = 2;
  
  I  = integr(a,b, h) + R(n, a,b, h);
    
  
end


