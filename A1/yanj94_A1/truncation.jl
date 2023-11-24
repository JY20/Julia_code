using CalculusWithJulia
using Plots

f(x) = sin(x) * exp(cos(x))
#setting the x to a definite value
x = 1
#getting the derviative of f
actual = ForwardDiff.derivative(f, x)

N = -16:1:0
h = 10.0 .^ N

# function to calculate f(x+h)-f(x-h)/2h
function fxh(x, h)
    return (f(x + h) - f(x - h)) / (2 * h)
end
approx = fxh.(x, h)

# calculate the error
error_f = []
for value in approx
    append!(error_f, abs.(value - actual))
end

# plot the error 
p = plot(h, error_f, xaxis=:log, yaxis=:log,
    label="Error vs h", color=:blue)
xaxis!("h")
yaxis!("Error")
savefig(p, "7c.png")