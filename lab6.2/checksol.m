function r=checksol(B, m)
  max_sum = 0;
  for i = 1 : m
    loc_sum = 0;
    
    for j = 1 : m
      loc_sum += abs(B(i,j));
    endfor
    
    if loc_sum > max_sum
      max_sum = loc_sum;
    endif
  endfor
  
  r = max_sum;
end