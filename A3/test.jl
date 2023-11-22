function adaptive_simpsons_rule(f, a, b, tol, max_depth)
    h = b - a
    c = (a + b) / 2

    left = (f(a) + 4 * f((a + c) / 2) + f(c)) * (c - a) / 6
    right = (f(c) + 4 * f((c + b) / 2) + f(b)) * (b - c) / 6
    a1 = left + right
    a2 = (f(a) + 4 * f(c) + f(b)) * h / 6

    if max_depth == 0 || abs((a1 - a2)) < 15 * tol
        return a1, [a, c, b]
    else
        left_integral, left_nodes = adaptive_simpsons_rule(f, a, c, tol / 2, max_depth - 1)
        right_integral, right_nodes = adaptive_simpsons_rule(f, c, b, tol / 2, max_depth - 1)
        nodes = vcat(left_nodes, right_nodes[2:end])
        return left_integral + right_integral, nodes
    end
end