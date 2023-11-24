using Plots
using LinearAlgebra
using Random

Random.seed!(304)
A = randn(5, 5)
b = randn(5)

x = A \ b
x_acc = BigFloat.(A) \ BigFloat.(b)
err = abs.(x_acc - x)

#Q1 outputs
println(cond(A))
println(norm(err))

valuesCond = [cond(A)]
valuesErr = [norm(err)]

for i in 1:49
    A = randn(5, 5)
    b = randn(5)

    x = A \ b
    x_acc = BigFloat.(A) \ BigFloat.(b)

    err = abs.(x_acc - x)

    append!(valuesCond, cond(A))
    append!(valuesErr, norm(err))
end

#Q2 outputs
plot(valuesCond, valuesErr, xaxis=:log, yaxis=:log, seriestype=:scatter,
    label="norm vs cond", color=:purple)