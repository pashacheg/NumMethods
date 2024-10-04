function r=f23_inv(x, n)
  r = 0;
  
  for i = n : -1 : 1
    r = r + (-1)^(i+1) * (2*i)/factorial(2*i-1) * x^(2*i-1);
  endfor
  
end