function r=func23(x)
  y1 = 0;
  y2 = 0;
  
  for i = 0 : 100
    y1 += x^i / factorial(i);
    y2 += ((-1) * x)^i / factorial(i);
  endfor
  
  r = (y1-y2) / (y1+y2);
end
