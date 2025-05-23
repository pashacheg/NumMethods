function M=web(a, b, h)
  M = [0 0];
  k = 1;
  
  for i = a : h : b
    lh = i + h;
    if (lh > b)
      lh = b;
    endif
        
    if (func(i) * func(lh) < 0)
      M(k,:) = [i lh];
      k += 1;
    endif
  endfor
end
