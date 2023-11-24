using Random
using LinearAlgebra
Random.seed!(99991099910101010)

include("assignment3_handout.jl")
# include("test.jl")

# Test the composite quadrature Rules
f(x) = exp(-x / 2) * sin(x)
f_int(x) = -2 * exp(-x / 2) * (sin(x) + 2 * cos(x)) / 5
a = 0.0
b = 4 * π
true_int = f_int(b) - f_int(a)

r = 2048
int_trap = composite_trapezoidal_rule(f, a, b, r)
int_mid = composite_midpoint_rule(f, a, b, r)
int_simpson = composite_simpsons_rule(f, a, b, r)

tol_composite = 1e-5
score_trap = (abs(int_trap - true_int) <= 1e-5) * 5
score_mid = (abs(int_mid - true_int) <= 1e-5) * 5
score_simpson = (abs(int_simpson - true_int) <= 1e-5) * 5

println("Score for the composite trapezoidal rule: $(score_trap)/5")
println("Score for the composite midpoint rule: $(score_mid)/5")
println("Score for the composite Simpson's rule: $(score_simpson)/5")

println("Preliminary score for Problem 1: $(score_trap+score_mid+score_simpson)/15")

# Test the adaptive Simpson's rule
f(x) = cos(x)
a = -π / 2
b = π / 2
true_int = sin(b) - sin(a)
tol_adapt = rand() * 1e-3
int_adapt, x = adaptive_simpsons_rule(f, a, b, tol_adapt, 10)
score_adapt = (abs(true_int - int_adapt) <= tol_adapt) * 15
# print(x)

println("Preliminary score for Problem 3: $(score_adapt)/15")

# Test out the Newton solver on a simple example
x_gt = ones(3)
x0 = x_gt + 0.5 * rand(3)
P = P = [0.0 1.0 0.5;
    0.0 0.0 1.0;
    0.0 0.0 0.0]
d = [norm(x_gt - P[:, i]) for i in 1:size(P, 2)]

tol = 1e-5
x_trace = newton(x0, P, d, tol, 20)

score_newton = (norm(x_trace[end] - x_gt) <= tol) * 10

println("Preliminary score for Problem 6: $(score_newton)/10")