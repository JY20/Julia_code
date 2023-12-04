using LinearAlgebra

# Define function for Forward Euler
function forEuler(f,t_in,t_end,y_in,h)
    
    # Define time array
    t = range(t_in,t_end,step=h);
    
    # Define output array
    y = [y_in];
    
    # Loop over all time instants
    for i = 2:length(t)
        y_new = y[end]+h*f(t[i-1],y[end]);
        append!(y,y_new)
    end
    
    # Return time and output
    return (t,y)
end

# Define function
f(t,y) = @. -2*t*y

# Define time limit and initial condition
t_in = 0.0;
t_end = 10.0;
h = 0.01;
y_in = 1.0;

# Apply Forward Euler's method
(t1,y_for1) = forEuler(f,t_in,t_end,y_in,h);

# Exact function
F(t) = @. exp(-t^2)


(t2,y_for2) = forEuler(f,0.0,10.0,y_in,0.3);


import Plots
Plots.plot(t1,abs.(y_for1 - F(t1)),label="",xlabel="t",ylabel="error")
Plots.plot(t2,abs.(y_for2),label="",xlabel="t",ylabel="y",yaxis=:log10)
