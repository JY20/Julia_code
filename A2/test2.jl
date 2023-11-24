using Polynomials
using Random

include("assignment2_handout.jl")

ω = 2.0
tol = 0.2
a = -π
b = π
N = 1000 # For plotting
x = range(a, stop=b, length=N)

# Use your solution to subdivide (evenly spaced nodes)
n = subdivide(a, b, ω, tol)
x_data = range(a, stop=b, length=n)
y_data = cos.(ω * x_data)
c_even = newton_int(x_data, y_data)
p_even = horner(c_even, x_data, x)