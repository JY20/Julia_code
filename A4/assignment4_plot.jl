using Plots
using LinearAlgebra
using DelimitedFiles

include("assignment4_handout.jl")

"""
Loads and relabels a Wikipedia voting dataset.
"""
function load_directed_graph()
    edges = readdlm("wiki-Vote.txt", '\t', Int)
    verts = sort(unique(edges))
    vert_map = Dict(verts[i] => i for i in 1:length(verts)) 
    edges_relabelled = zeros(Int, size(edges))
    for i in 1:size(edges, 1)
        for j in 1:size(edges, 2)
            edges_relabelled[i, j] = vert_map[edges[i, j]]
        end
    end
    return edges_relabelled
end

"""
Get the indegree of each vertex in the directed graph described by edges.
"""
function indegrees(edges)
    n_vert = maximum(edges)
    d = zeros(Int, n_vert)
    for i in 1:size(edges, 1)
        d[edges[i, 2]] += 1
    end
    return d
end

# Run PageRank on the Wikipedia graph
edges = load_directed_graph()
tol = 1e-6
v = page_rank(edges, tol)

# Make a scatterplot (include this in your PDF)
d_in = indegrees(edges)
scatter(d_in, v, label="Vertices")
xlabel!("Indegree")
ylabel!("PageRank")
title!("PageRank vs. Indegree for All Vertices")