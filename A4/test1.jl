using LinearAlgebra

function power_method_symmetric(A, tol)
    n = size(A, 1)

    # Ensure matrix A is symmetric
    @assert isapprox(A, A', atol=1e-8)

    # Initialize a random vector as an initial guess
    v = randn(n)
    v /= norm(v)

    λ_prev = 0.0
    λ = dot(v, A * v)

    iter = 0

    while abs(λ - λ_prev) > tol 
        v = A * v
        v /= norm(v)

        λ_prev = λ
        λ = dot(v, A * v)

        # iter += 1

        # # Add a safeguard for maximum iterations
        # if iter >= 1000
        #     error("Power method did not converge within 1000 iterations.")
        # end
    end

    return λ, v
end




"""
Compute the PageRank algorithm, as described in the assignment handout, 
on a directed graph described by its edges. In the description of inputs 
below, m is the number of directed edges, and n is the number of vertices. 
Assume that the vertices are named 1, 2, ..., n. 

Inputs:
    edges: a m-by-2 matrix of integers containing directed edges, where 
           the first column contains the source of each edge and the 
           second column contains the destination of each edge.  
    tol: error tolerance; i.e., the maximum eigenvalue estimate 
         must be within tol of the true maximum eigenvalue of 1

Outputs:
    v: the eigenvector corresponding to the eigenvalue λ₁ = 1 for the 
       transition matrix induced by the directed graph described by 
       the input edges. 
"""
function page_rank(edges, tol)
    # Extract the number of vertices from the edges
    n = maximum(edges)

    # Construct the transition matrix
    A = zeros(n, n)
    for edge in edges
        A[edge[2], edge[1]] = 1  # Edges go from column to row in transition matrix
    end

    # Normalize the columns to make it a stochastic matrix
    col_sum = sum(A, dims=1)
    A ./= col_sum

    # Compute the PageRank using the power method
    v = power_method_symmetric(A, tol)

    return v
end