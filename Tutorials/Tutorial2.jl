import LinearAlgebra as linearAlgebra
using Plots

function f(X)
    value = linearAlgebra.det(log2.(X))
    return value
end

X = [2 3 4; 0.3 1.6 1; 5 2.3 1.1]

dif = (f(Float64.(X)) - f(Float32.(X)));
println(f(Float64.(X)));
println(f(Float32.(X)));
println(abs(dif));
println(abs(dif / eps()));

x = range(-10, 10, length=50)
x1 = -10:1:10;
y = sin.(x)
plot(x, y)