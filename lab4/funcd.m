function r=funcd(x)
  #(1−x^2)sinh(x)−2xcosh(x)
    r = (1-x^2) * (exp(x)-exp((-1)*x)) / 2 - x * (exp(x)+exp((-1)*x));

end
