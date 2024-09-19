function r=f22_dir(x, n)
  r = 0;
  
  for i = 1 : n
    r = r + (-1)^(i+1) * (1/n + 1/factorial(2*i-1)) * x^(2 * i);
  endfor
  
end
