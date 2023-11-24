""" 
Computes the coefficients of Newton's interpolating polynomial. 
    Inputs 
        x: vector with distinct elements x[i] 
        y: vector of the same size as x 
    Output 
        c: vector with the coefficients of the polynomial
"""
function newton_int(x, y)
    # applying newton with matrix for the coefficients 
    size = length(x)
    c = []
    values = zeros((size, size))
    for i in 1:size
        values[1, i] = y[i]
    end
    for i in 2:size
        count = 1
        for j in i:size
            values[i, j] = (values[i-1, j] - values[i-1, j-1]) / (x[j] - x[count])
            count += 1
        end
    end
    for i in 1:size
        append!(c, values[i, i])
    end
    return c
end

"""
Evaluates a polynomial with Newton coefficients c 
defined over nodes x using Horner's rule on the points in X.
Inputs 
    c: vector with n coefficients 
    x: vector of n distinct points used to compute c in newton_int 
    X: vector of m points 
Output 
    p: vector of m points
"""
function horner(c, x, X)
    # applying horner to calculate the p values
    p = []
    size = length(x)
    temp = 0
    for i in 1:length(X)
        temp = c[size]
        for j in 2:size
            temp = c[size+1-j] + temp * (X[i] - x[size+1-j])
        end
        append!(p, temp)
    end
    return p
end

"""
Computes the number of equally spaced points to use for 
interpolating cos(ω*x) on interval [a, b] for an absolute
error tolerance of tol.

Inputs
    a: lower boundary of the interpolation interval
    b: upper boundary of the interpolation interval
    ω: frequency of cos(ω*x)
    tol: maximum absolute error 
Output
    n: number of equally spaced points to use 	 
"""
function subdivide(a, b, ω, tol)
    # applying the evenly spaced to find min n 
    n = 1
    while true
        h = (b - a) / (n - 1)
        err = (n) -> @. ((ω^(n)) * h^(n)) / (4 * (n))
        errs = err(n)
        value, index = findmax(errs)
        if (value <= tol)
            println(n)
            return n
        else
            n += 1
        end
    end
end

"""
Computes Chebyshev nodes in the interval [a, b] for the function
cos(ω*x) for a maximum absolute error of tol.

Inputs
    a: lower boundary of the interpolation interval
    b: upper boundary of the interpolation interval
    ω: frequency of cos(ω*x)
    tol: maximum absolute error
Output
    x: distinct Chebyshev nodes	 
"""
function chebyshev_nodes(a, b, ω, tol)
    # applying the Chebyshev nodes to find min n and calculate the x values
    x = []
    n = 1
    while true
        err = (n) -> @. ((b - a) * ω / 2)^(n) / (2^(n - 1) * factorial(n))
        errs = err(n)
        value, index = findmax(errs)
        if (value <= tol)
            println(n)
            for i in 0:n-1
                value = 1 / 2 * (a + b) + 1 / 2 * (b - a) * (cos(((2 * i + 1) * pi) / (2 * n)))
                append!(x, value)
            end
            return x
        else
            n += 1
        end
    end
end