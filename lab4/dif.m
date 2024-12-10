function res=dif(x, h, n)
  if (n == 1)
    res = (func(x+h) - func(x-h)) / (2*h);
  else
    res = (func(x+h) - 2*func(x) + func(x-h)) / (h^2);
  endif
end
