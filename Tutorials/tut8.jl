using Plots

function secant(f, x0, x1, max_iter, toll)
    iter = 1
    x_old = x1
    x_old_old = x0
    x_new = x_old - f(x_old) * (x_old - x_old_old) / (f(x_old) - f(x_old_old))
    x_hist = [x0; x_new]
    while iter <= max_iter && abs(x_new - x_old) >= toll
        x_old = x_new
        x_new = x_old - f(x_old) * (x_old - x_old_old) / (f(x_old) - f(x_old_old))
        x_old_old = x_old
        iter += 1
        push!(x_hist, x_new)
    end
    return x_hist
    return 1
end

x0a = -2.5;
x1a = -2.2;
f(x) = @. -x^4 + 3x^2 - x + 2

x_history = secant(f, x0a, x1a, 100, 10^-6)

println("The secont's method converges to $(x_history[end]) in $(length(x_history)) iterations.")

x_star = -2;
n = 1:length(x_history);
err = abs.(x_history .- x_star);

c = 1 / 2 * 69 / 3.5;
phi = (sqrt(5) + 1) / 2
err_theory = c * (err[1:end-1]) .^ 2;
err_lim = c * (err[1:end-1]) .^ phi;

if err[end] == 0.0
    err[end] = 1e-24
end

println("The error converges to $(err_lim[end])")

Plots.plot(n, err, yscale=:log10, xlabel="Iteration", ylabel="Absolute Error", label="e_i")
Plots.plot!(n[2:end], err_lim, linestyle=:dash, label="Limit")
Plots.plot!(n[2:end], err_theory, linestyle=:dash, label="Limit")