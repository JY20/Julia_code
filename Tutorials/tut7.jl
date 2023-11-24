using Plots

a = 0
b = 6
f(x) = @. sin(x)^2

n = 101 - 1
h = (b - a) / n
x = a:h:b

function trapezoid()
    result = h / 2 * (f(a) + f(b))
    for i = 1:n-1
        result = result + h * f(a + h * i)
    end
    return result
end

time_trapezoid_sum = 0
counter = 0
for i in 1:11
    global time_trapezoid_sum += @elapsed trapezoid()
    global counter += 1
end

time_trapezoid = time_trapezoid_sum / counter
println("elapsed time for trapezoid:", time_trapezoid)

err = abs((1 / 2) * (6 - (1 / 2) * sin(12)) - trapezoid())
println("Integration error using 3 nodes:\t", err)
println("Maximum integration error (3 nodes):\t", 1 / 12 * (b - a) * h^2 * 2)

function simpson()
    result_sim = (f(a) + f(b))
    for i = 1:(div(n, 2)-1) # floor divide
        result_sim = result_sim + 2 * f(a + h * (2 * i))
    end
    for i = 1:(div(n, 2)) # floor divide
        result_sim = result_sim + 4 * f(a + h * (2 * i - 1))
    end
    result_sim = result_sim * h / 3
    return result_sim
end

time_simpson_sum = 0
counter = 0
for i in 1:11
    global time_simpson_sum += @elapsed simpson()
    global counter += 1
end

time_simpson = time_simpson_sum / counter
println("elapsed time for simpson:", time_simpson)

err_sim = abs((1 / 2) * (6 - (1 / 2) * sin(12)) - simpson())
println("Integration error:\t\t", err_sim)
println("Maximum integration error:\t", 1 / 180 * (b - a) * h^4 * 24)