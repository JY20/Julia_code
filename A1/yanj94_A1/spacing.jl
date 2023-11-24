using Plots

# range and spacing
a = Float64(0)
b = Float64(5)
n = Float64(100)

h = (b - a) / n

# array of xi values
values1 = [a]
values1_acc = [BigFloat.(a)]
values2 = [a]
values2_acc = [BigFloat.(a)]


# calculates by using different methods
for i in 1:Int(n)
    append!(values1, values1[i] + h)
    append!(values1_acc, values1_acc[i] + BigFloat.(h))
    append!(values2, a + i * h)
    append!(values2_acc, BigFloat.(a) + i * BigFloat.(h))
end


# plot the errors
p = plot(abs.(values1 - values1_acc), label="Error in Method 1")
plot!(abs.(values2 - values2_acc), label="Error in Method 2")

xaxis!("xi")
yaxis!("Error")
savefig(p, "6b.png")