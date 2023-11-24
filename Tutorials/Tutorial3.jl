using LinearAlgebra
using Plots
using Random

value = [];
value2 = [];

Random.seed!(412)

for i = 1:50
    println(i)
    randomMatrix = randn(3, 3)
    eigentest = eigen(Symmetric(randomMatrix))
    vals, vecs = eigentest
    append!(value, vals)
end

n = 20
histogram(value)