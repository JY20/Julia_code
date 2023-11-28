using LinearAlgebra
using Random

Random.seed!(8675309)

include("assignment4_handout.jl")

tol = 1e-9
n = 100
n_runs = 10

problem1_score = 0

for i in 1:n_runs
    A = 1000.0*rand(n, n) .- 500.0
    A = Symmetric(A)
    true_eigs = eigen(A)
    max_val_ind = argmax(abs.(true_eigs.values))
    v0 = rand(n)
    λ_pow, _ = power_method_symmetric(A, tol)
    global problem1_score += (abs(λ_pow - true_eigs.values[max_val_ind]) <= tol)
end

println("Your score for Problem 1 is $(problem1_score)/$(n_runs)")

# Problem 2: PageRank on a toy example
edges_test = [1 2;
              1 4;
              2 3;
              2 6;
              3 1;
              3 4;
              3 6;
              4 2;
              4 5;
              5 2;
              5 6;
              6 3]

tol_page_rank = 1e-6
v_test = page_rank(edges_test, tol_page_rank)
v_ground_truth = [0.0994;
                  0.1615;
                  0.2981;
                  0.1491;
                  0.0745;
                  0.2174]
problem2_score = 20*(norm(v_test - v_ground_truth) < 1e-4)

println("Your score for Problem 2 is $(problem2_score)/20")
