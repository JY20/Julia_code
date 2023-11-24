using Plots

# Define the function and its gradient
function evaluate_function_and_gradient(x)
    f = (x[1] - 1)^2 + (x[2] - 2)^2
    grad_f = [2 * (x[1] - 1), 2 * (x[2] - 2)]
    return f, grad_f
end

# Define the Hessian matrix
function evaluate_hessian(x)
    return [2 0; 0 2]
end

# Check if the Hessian is positive definite
function is_positive_definite(hessian)
    eigenvalues = eigvals(hessian)
    return all(eig -> eig > 0, eigenvalues)
end

# Implement Newton's method
function newtons_method(x0, tol, max_iters)
    x = copy(x0)
    x_trace = [copy(x)]

    for _ in 1:max_iters
        f, grad_f = evaluate_function_and_gradient(x)

        if norm(grad_f) <= tol
            hessian = evaluate_hessian(x)
            if is_positive_definite(hessian)
                println("Hessian at the critical point is positive definite.")
            else
                println("Hessian at the critical point is not positive definite.")
            end
            break
        end

        hessian = evaluate_hessian(x)
        x -= inv(hessian) * grad_f

        push!(x_trace, copy(x))
    end

    return x_trace
end

# Initial guess
x0 = [0.0, 0.0]

# Tolerance and maximum iterations
tolerance = 1e-6
max_iterations = 50

# Run Newton's method
x_trace = newtons_method(x0, tolerance, max_iterations)

# Plot the convergence
x_vals = [x[1] for x in x_trace]
y_vals = [x[2] for x in x_trace]

plot(x_vals, y_vals, marker=:circle, label="Newton's method iterates", xlabel="x1", ylabel="x2", legend=:bottomright)
