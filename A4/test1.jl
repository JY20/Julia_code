using LinearAlgebra

function power_method_symmetric(A, tol)
    n = size(A)[1]
    v = rand(n)
    λ = 0
    for i in 1:10000
        v = A * v
        v = v / norm(v)
        λ = v' * A * v
        r = A * v - λ * v
        if norm(r) / norm(v) < tol #Bauer-Fike theorem
            break
        end
    end
    return λ, v
end



function page_rank(edges, tols)
    max_iter = 20000
    iter = 1

    n = maximum(edges)
    P = zeros(n, n)

    for edge in eachrow(edges)
        P[edge[2], edge[1]] += 1
    end

    for j in 1:n
        if sum(P[:, j]) == 0
            P[:, j] .= 1 / n
        else
            P[:, j] ./= sum(P[:, j])
        end
    end
    
    v=rand(n) 

    v ./= sum(v)

    new_v = P*v
    while iter < max_iter && norm(new_v- v, 1) > tol
        v = new_v
        new_v = P*v
        new_v ./= sum(new_v)
        iter += 1
    end
    return v
    # n = maximum(edges) # number of vertices
    # P = zeros(Float64, n, n) # transition matrix

    # # Populate the transition matrix P
    # for edge in eachrow(edges)
    #     P[edge[2], edge[1]] += 1
    # end

    # # Normalize each column
    # for j in 1:n
    #     if sum(P[:, j]) == 0
    #         P[:, j] .= 1 / n
    #     else
    #         P[:, j] ./= sum(P[:, j])
    #     end
    # end

    # # Initialize a random vector
    # v = rand(Float64, n)
    # # v ./= sum(v)

    # for i in length(v)
    #     v[i] /= sum(v)
    # end

    # max_iter = 1000
    # tol = 1e-6

    # # Power method iteration
    # for iter in 1:max_iter
    #     v_new = P * v
    #     v_new ./= sum(v_new)

    #     if norm(v_new - v, 1) < tol
    #         break
    #     end

    #     v = v_new
    # end

    # # Handle dead-end webpages
    # for i in 1:n
    #     if sum(P[i, :]) == 0
    #         v[i] = 1 / n
    #     end
    # end

    # # Return the PageRank scores
    # return v
end