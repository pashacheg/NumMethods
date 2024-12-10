function r=funcdd(x)
    #(−x^2−1)cosh(x)−4xsinh(x)
    r = ((-1)*x^2 - 1) * (exp(x)+exp((-1)*x))/2 - 2 * x * (exp(x)-exp((-1)*x));
end
