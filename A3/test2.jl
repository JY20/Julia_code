function nonlinear_optimization(x0, P, d, tol, max_iters)
    x = copy(x0)
    x_trace = [copy(x0)]

    for _ in 1:max_iters
        # Evaluate the function and its gradient
        f, grad_f = evaluate_function_and_gradient(x, P, d)

        # Check the stopping condition
        if norm(grad_f) <= tol
            break
        end

        # Evaluate the Hessian matrix
        hessian = evaluate_hessian(x, P)

        # Update x using Newton's method
        x -= inv(hessian) * grad_f

        # Append the current iterate to the trace
        push!(x_trace, copy(x))
    end

    return x_trace
end

function evaluate_function_and_gradient(x, P, d)
    n, m = size(P)
    f = 0.0
    grad_f = zeros(n)

    for i in 1:m
        g_k = norm(x - P[:, i])
        f += (g_k - d[i])^2
        grad_f .+= 2 * (g_k - d[i]) * (x - P[:, i]) / g_k
    end

    return f, grad_f
end

function evaluate_hessian(x, P)
    n, m = size(P)
    hessian = zeros(n, n)

    for i in 1:n
        for j in 1:n
            for k in 1:m
                g_k = norm(x - P[:, k])
                hessian[i, j] += 2 * ((x[i] - P[i, k]) * (x[j] - P[j, k]) / g_k^3 -
                                      (x[i] - P[i, k]) * (x[j] - P[j, k]) / g_k)
            end
        end
    end

    return hessian
end

# Example usage:
# x0 = initial guess
# P = nxm matrix with known locations of transmitting beacons as columns
# d = vector in R^m where d[i] contains the noisy distance from beacon P[:, i] to x
# tol = Euclidean error tolerance
# max_iters = maximum iterations of Newton's method to try
# x_trace = nonlinear_optimization(x0, P, d, tol, max_iters)
