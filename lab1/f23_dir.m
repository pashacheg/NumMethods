function r=f23_dir(x, n)
  r = 0;
  
  for i = 1 : n
    r = r + (-1)^(i+1) * (2*i)/factorial(2*i-1) * x^(2*i-1);
  endfor
  
end