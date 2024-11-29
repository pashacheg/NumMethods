function r=polynom(X, Y, n, t)
    r = 0;
    
    for i = 1 : n
      y = Y(i);
      
      for j = 1 : n
        if (i == j) 
          continue;
        endif
        
        y *= (t-X(j)) / (X(i)-X(j));
      endfor
      
      r += y;
    endfor
    
end