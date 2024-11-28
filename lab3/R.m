function r=R(n, a,b, h)
  if (n == 1)
    r = h/2 * (func23(a)-func23(b));
  else
    S = 0;
    for i = 1 : (2^n - 1)
      S += func23(a + (2*i - 1)*h);
    endfor
    S *= h;
    r = 0.5 * R(n-1, a,b, h) + S;
  endif
end