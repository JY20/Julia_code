using Plots

#Function getting factorial
function getFactorial(n::Int)
    factorialValue = 1
    for i = 1:n
        factorialValue = factorialValue * i
    end
    return factorialValue
end

#Function for expm1mx
function expm1mx(x)
    #prevent x greater to 1
    if (x > 1 || x < -1)
        println("x entered have a magnitude greater to 1")
        return 0
    else
        #calculates the values by using the Taylor series for Eulers Series
        #The 1 + x gets cancel out with -1-x and we can reduce the error by eliminating all the substraction
        #Just 18 terms to approx Eulers number
        value = 0
        for i = 2:18
            value += (x^i) / getFactorial(i)
        end
        return (value) / x^2
    end
end


# Define our function and domain
f(x) = (exp(x) - 1 - x) / x^2
N = -16:1:0
x = 10.0 .^ N
# Compute accurate values in higher precision
accurate = f.(BigFloat.(x))
# Relative error in f(x)
error_f = abs.((f.(x) - accurate) ./ accurate)
# Relative error in expm1mx(x)
error_app = abs.((expm1mx.(x) - accurate) ./ accurate)
# Plot and save the output
p = plot(x, error_f, xaxis=:log, yaxis=:log,
    label="Rel. Error in f(x)", color=:blue)
plot!(x, error_app, xaxis=:log, yaxis=:log,
    label="Rel. Error in expm1mx(x)", color=:red)
xaxis!("x")
yaxis!("Relative Error")
savefig(p, "relative_error.png")