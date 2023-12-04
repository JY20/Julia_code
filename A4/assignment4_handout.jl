using LinearAlgebra

"""
Computes the maximum magnitude eigenpair for the real symmetric matrix A 
with the power method. Ensures that the error tolerance is satisfied by 
using the Bauer-Fike theorem.

Inputs:
    A: real symmetric matrix
    tol: error tolerance; i.e., the maximum eigenvalue estimate 
         must be within tol of the true maximum eigenvalue

Outputs:
    λ: the estimate of the maximum magnitude eigenvalue
    v: the estimate of the normalized eigenvector corresponding to λ
"""
function power_method_symmetric(A, tol)
    # Applying the power method to real symmetric matrices
    max_iter = 20000
    iter = 1

    n = size(A,1)
    v = rand(n)
    λ = 0
    r = A*v-λ*v
    while iter < max_iter && norm(r)/norm(v) > tol #Bauer-Fike Therorem
        v = A*v
        v = v/norm(v)
        λ = transpose(v)*A*v
        r = A*v-λ*v
        iter += 1
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
    # Applying page rank algorithm
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
end