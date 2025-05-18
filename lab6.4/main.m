function r=main()
  a = 0.98;
  b = 1.01;
  x0 = 0.9;
  x1 = 1.1;
  
  S = [];
  F = [];
  for k = 1 : 1000
    S = [S 0.002*k];
    F = [F func(S(k))];
  endfor
  bx = bisection(a,b, 1)
  by = func(bx);
  sx = section(x0,x1, 1)
  sy = func(sx);
  
  figure(1)
  plot(S,F);
  hold on;
  plot(S,zeros(1000, 1), "k--");
  hold on;
  plot(bx,by, "ro");
  hold on;
  plot(sx,sy, "ro");
  grid on
  leg = legend("f(x)", "zero", "bisection", "section");
  set (leg, "fontsize", 16);
  
  figure(2)
  bisection(a,b, 2);
  section(x0,x1, 2);
  grid on
  leg = legend("bisection", "section");
  set (leg, "fontsize", 16);
  
  figure(3)
  bisection(a,b, 3);
  section(x0,x1, 3);
  grid on
  leg = legend("error (bisection)", "residual (bisection)", "error (section)", "residual (section)")
  set (leg, "fontsize", 16);
end
