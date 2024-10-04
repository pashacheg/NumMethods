function r=f23_gor(x, n)
  r = 0;
  
  for i = n : -1 : 1
    r = x * ((-1)^(i+1) * (2*i)/factorial(2*i-1) + x * r);
  endfor
  
  
end