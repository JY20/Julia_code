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
    return v
end