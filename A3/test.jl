function newton(x0, P, d, tol, max_iters)
    iter = 1
    x_trace = []
    n = length(x0)

    function F(x)
        Fx = zeros(n)
        for i in 1:n
            Fx[i] = norm(x - P[:, i]) - d[i]
        end
        return Fx
    end

    function J(x)
        Jx = zeros(n, n)
        for i in 1:n
            for j in 1:n
                Jx[i, j] = (x[j] - P[j, i]) / norm(x - P[:, i])
            end
        end
        return Jx
    end

    x = copy(x0)
    x_trace = [copy(x)]
    while iter <= max_iters && norm(F(x)) > tol
        dx = J(x) \ F(x)
        x = x - dx
        # print(dx)
        iter += 1
        push!(x_trace, copy(x))
    end
    return x_trace
    # while norm(F(x)) > tol && iter < max_iters
    #     dx = J(x) \ F(x)
    #     x = x - dx
    #     push!(x_trace, copy(x))
    #     iter += 1
    # end
    # return x_trace
end