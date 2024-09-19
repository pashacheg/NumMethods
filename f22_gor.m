function r=f22_gor(x, n)
  r = 0;
  
  for i = n : -1 : 1
    r = x * ((-1)^(i+1) * (1/n + 1/factorial(2*i-1)) + x * r);
  endfor
  
  r = r * x;
  
end
