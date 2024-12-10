function r=polynom(X, Y, n, t)
    r = 0;
    
    for i = 1 : n
      y = Y(i);
      
      for j = 1 : n
        if (i == j) 
          continue;
        endif
        
        y *= (t-X(j)^2) / (X(i)^2-X(j)^2);
      endfor
      
      r += y;
    endfor
    
end