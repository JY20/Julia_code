using Polynomials
using Random

include("assignment2_handout.jl")

# The actual test seed to be used is hidden
# if ((n + 1) % 4 == 0)
#     err = (x) -> @. (cos(x) * (ω^(n - 1)) * h^(n)) / (4 * (n))
# elseif ((n + 1) % 4 == 1)
#     err = (x) -> @. (-sin(x) * (ω^(n - 1)) * h^(n)) / (4 * (n))
# elseif ((n + 1) % 4 == 2)
#     err = (x) -> @. (-cos(x) * (ω^(n - 1)) * h^(n)) / (4 * (n))
# elseif ((n + 1) % 4 == 3)
#     err = (x) -> @. (sin(x) * (ω^(n - 1)) * h^(n)) / (4 * (n))
# end
# x = a:h:b
# xValues = a:h:b
Random.seed!(99991099910101010)
rel_tol = 1e-6

x = [1, 2, 4, 3]
y = [1, 3, 3, 5]

n = rand(5:10)
x = range(-1.0, stop=1.0, length=n)
y = rand(length(x))

X = y

p_true = fit(x, y)
c_n = newton_int(x, y)
println(p_true)
println(c_n)

vals = horner(c_n, x, X)
vals_true = p_true.(X)
println(vals)
println(vals_true)

score = sum(abs.((vals .- vals_true) ./ vals_true) .<= rel_tol)
