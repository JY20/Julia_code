f(x) = exp(x) - 1 - x
#  / x^2;
k(x) = exp(x) - x
# - 1
# - x)
#  - 1)
# / x^2;
x = 1e-10;
# x = 2^(-33);
println(typeof(x))
println(exp(1e-10) - 1);
y = exp(2^(-33))
z = 2 / 3
println(y);
println("x=$(x)")
println("f(x)=$(f(x))")
println("k(x)=$(k(x))")
# x = 2^(-33);
# println("x=$(x)")
# println("g(x)=$(g(x))")
# println("h(x)=$(h(x))")