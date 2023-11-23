function newton(x0, P, d, tol, max_iters)
    n = length(x0)
    x = copy(x0)
    x_trace = [copy(x)]

    function F(x)
        Fx = zeros(n)
        for i in 1:n
            Fx[i] = norm(x - P[:, i]) - d[i]
        end
        return Fx
    end

    function jacobian(x)
        J = zeros(n, n)
        for i in 1:n
            for j in 1:n
                J[i, j] = (x[j] - P[j, i]) / norm(x - P[:, i])
            end
        end
        return J
    end

    iter = 0
    while norm(F(x)) > tol && iter < max_iters
        Δx = -jacobian(x) \ F(x)
        x += Δx
        push!(x_trace, copy(x))
        iter += 1
    end
    return x_trace
end