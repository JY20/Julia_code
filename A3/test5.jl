x_trace = [x0]
xi = x0
for iter = 1:max_iters
    n = length(xi)
    m = length(P[1])
    grad = zeros(n)
    hess = zeros(n, n)
    for i = 1:n
        grad[i] = 0
        for k = 1:m
            norm_vec = norm(xi .- P[:, k])
            grad[i] += (xi[i] - P[i, k]) * (1 - d[k] * norm_vec^-1)
        end
        grad[i] *= 2
    end
    for i = 1:n
        for j = 1:n
            hess[i, j] = 0
            if i == j
                for k = 1:m
                    norm_vec = norm(xi .- P[:, k])
                    hess[i, j] += 1 - d[k] * norm_vec^-1 + (xi[i] - P[i, k]) * (d[k] * (xi[i] - P[i, k]) * norm_vec^-3)
                end
                hess[i, j] *= 2
            else
                for k = 1:m
                    norm_vec = norm(xi .- P[:, k])
                    hess[i, j] += (xi[i] - P[i, k]) * (d[k] * (xi[j] - P[j, k]) * norm_vec^-3)
                end
                hess[i, j] *= 2
            end
        end
    end
    xi = xi - inv(hess) * grad
    push!(x_trace, xi)
    error = norm(grad)
    if error <= tol
        return x_trace
    end
end
return x_trace


"""
Compute the integral ∫f(x)dx over [a, b] with the composite trapezoidal 
rule using r subintervals.

Inputs:
    
    f: function to integrate
    a: lower bound of the definite integral
    b: upper bound of the definite integral
    r: number of subintervals
"""
function composite_trapezoidal_rule(f, a, b, r)
    h = (b - a) / r
    value = (h / 2) * (f(b) - f(a))
    sum = 0
    for i = 1:r-1
        sum += f(a + i * h)
    end
    return value + h * sum
end

"""
Compute the integral ∫f(x)dx over [a, b] with the composite midpoint 
rule using r subintervals.

Inputs:
    
    f: function to integrate
    a: lower bound of the definite integral
    b: upper bound of the definite integral
    r: number of subintervals
"""
function composite_midpoint_rule(f, a, b, r)
    sum = 0
    h = (b - a) / r
    for i = 1:r
        sum += f(a + i * h - h / 2)
    end
    return sum * h
end

"""
Compute the integral ∫f(x)dx over [a, b] with the composite Simpson's 
rule using r subintervals. Note that r must be even because each 
application of Simpson's rule uses a subinterval of length 2*(b-a)/r.
In other words, the midpoints used by the basic Simpson's rule are 
included in the r+1 points on which we evaluate f(x).

Inputs:
    
    f: function to integrate
    a: lower bound of the definite integral
    b: upper bound of the definite integral
    r: even number of subintervals
"""
function composite_simpsons_rule(f, a, b, r)
    h = (b - a) / r
    value = f(a) + f(b)
    sum1 = 0
    for i = 1:((r/2)-1)
        sum1 += f(a + (2 * i) * h)
    end
    sum2 = 0
    for i = 1:(r/2)
        sum2 += f(a + (2 * i - 1) * h)
    end
    value += 2 * sum1
    value += 4 * sum2
    return (h / 3) * value
end

"""
Compute the integral ∫f(x)dx over [a, b] with the adaptive Simpson's 
rule. Return the approximate integral along with the nodes (points) x 
used to compute it.  

Inputs:
    
    f: function to integrate
    a: lower bound of the definite integral
    b: upper bound of the definite integral
    tol: maximum error we can approximately tolerate (i.e., |If - Q| <≈ tol)
    max_depth: maximum number of times this function should be recursively called

Returns:
    approximate_integral: the value of the integral ∫f(x)dx over [a, b]
    x: vector containing the nodes which the algorithm used to compute approximate_integral
"""
function adaptive_simpsons_rule(f, a, b, tol, max_depth)
    h = b - a
    c = (a + b) / 2

    one_simpson = (f(a) + 4 * f(c) + f(b)) * h / 6

    left = (f(a) + 4 * f((a + c) / 2) + f(c)) * (c - a) / 6
    right = (f(c) + 4 * f((c + b) / 2) + f(b)) * (b - c) / 6
    two_simpson = left + right

    if abs(two_simpson - one_simpson) < 15 * tol || max_depth == 0
        return (two_simpson + (two_simpson - one_simpson) / 15), [a, b, c]
    end

    int_adapt_left, x_left = adaptive_simpsons_rule(f, a, c, tol / 2, max_depth - 1)
    int_adapt_right, x_right = adaptive_simpsons_rule(f, c, b, tol / 2, max_depth - 1)

    x = vcat(x_left, x_right[2:end])
    return (int_adapt_left + int_adapt_right), x
end


"""
Use Newton's method to solve the nonlinear system of equations described in Problem 5.
This should work for Euclidean distance measurements in any dimension n.

Inputs:
    x0: initial guess for the position of the receiver in R^n
    P: nxn matrix with known locations of transmitting beacons as columns
    d: vector in R^n where d[i] contains the distance from beacon P[:, i] to x
    tol: Euclidean error tolerance (stop when norm(F(x)) <= tol)
    max_iters: maximum iterations of Newton's method to try

Returns:
    x_trace: Vector{Vector{Float64}} containing each Newton iterate x_k in R^n. 

"""
function newton(x0, P, d, tol, max_iters)
    iter = 1
    x_trace = []
    n = length(x0)

    function F(x)
        Fx = zeros(n, n)
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
    append!(x_trace, x)
    while iter <= max_iters && (norm(F(x))) > tol
        dx = -J(x) \ F(x)
        # x += dx
        print(dx)
        iter += 1
        append!(x_trace, x)
    end
    return x_trace
end

"""
Use Newton's method to solve the nonlinear optimization problem described in Problem 7.
This should work for Euclidean distance measurements in any dimension n, and any number 
    of noisy measurements m.

Inputs:
    x0: initial guess for the position of the receiver in R^n
    P: nxm matrix with known locations of transmitting beacons as columns
    d: vector in R^m where d[i] contains the noisy distance from beacon P[:, i] to x
    tol: Euclidean error tolerance (stop when norm(∇f(x)) <= tol)
    max_iters: maximum iterations of Newton's method to try

Returns:
    x_trace: Vector{Vector{Float64}} containing each Newton iterate x_k in R^n. 

"""
function newton_optimizer(x0, P, d, tol, max_iters)
    iter = 1
    x_trace = []
    n, m = size(P)
    n = length(x0)

    function gradient(x)
        g = zeros(n)
        for i in 1:n
            sum = 0
            for j = 1:m
                sum += ((x[i] - P[i, j]) / norm(x - P[:, j])) * (norm(x - P[:, j]) - d[j])
            end
            g[i] = 2 * sum
        end
        return g
    end

    function hessian(x)
        h = zeros(n, n)
        for i in 1:n
            for j in 1:n
                sum = 0
                if (j == i)
                    for k in 1:m
                        sum += (1 - d[k] / norm(x - P[:, k])) + (d[k] * (x[i] - P[i, k])^2) / (norm(x - P[:, k]))^3
                    end
                else
                    for k in 1:m
                        sum += ((x[i] - P[i, k]) * (x[j] - P[j, k]) * d[k]) / (norm(x - P[:, k]))^3
                    end
                end
                h[i, j] = 2 * sum
            end
        end
        return h
    end

    x = copy(x0)
    x_trace = [copy(x)]
    while iter <= max_iters && (norm(gradient(x))) > tol
        dx = inv(hessian(x)) * gradient(x)
        x = x - dx
        iter += 1
        push!(x_trace, x)
    end

    println("Numerical Evidence of part a")
    println(norm(gradient(x)))
    println(norm(gradient(x)) <= tol)
    println("Numerical Evidence of part b")
    value = eigvals(hessian(x))
    println(value)
    allGreaterZero = true
    for i in 1:length(value)
        if (value[i] < 0)
            allGreaterZero = false
        end
    end
    println(allGreaterZero)

    return x_trace
end