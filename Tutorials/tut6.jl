using Plots

x = [1, 2, -0.5, -2, 2]
y = [2, 3.35631, 0.76225, 0.126, 4.2563]
n = 5

A = [x'*x sum(x); sum(x) n];
b = [x' * y; sum(y)];
Coeff = A \ b;

println("Coefficent for linear")
display(Coeff)
linear_eq(x) = @. Coeff[2] + Coeff[1] * x

log_y = log.(y)

a_exp = [sum(x' * x) sum(x); sum(x) n]
b_exp = [sum(x' * log_y); sum(log_y)]
Coeff_exp = a_exp \ b_exp

println("Coefficent for log")
display(Coeff_log)
log_eq(x) = @. exp(Coeff_exp[2]) * exp(Coeff_exp[1] * x)

err_linear = abs.(linear_eq(x) - y)
err_log = abs.(log_eq(x) - y)

println("Max error for linear: $(findmax(err_linear)[1])")
println("Max error for exp: $(findmax(err_log)[1])")

println("Sum of error for linear: $(sum(err_linear))")
println("Sum of error for exp: $(sum(err_log))")

x_values = -3:0.01:3
plot(x_values, linear_eq(x_values), label="linear", color=:blue)
scatter!(x, y, label="Nodes", markercolor=:green)
plot!(x_values, log_eq(x_values), label="exp", color=:red)