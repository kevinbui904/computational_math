# A file to get you started on fitting a line via absolute deviation.
# This file provides the data you are supposed to fit, and plots that data.

using Plots, JuMP, GLPK

# The data that you'll we'll fit a line to.
xdata = [0.3528, 0.2437, 0.6639, 0.4278, 0.4021, 0.9102, 0.7712, 0.8624, 0.9876, 0.9265, 0.5557, 0.4514];
ydata = [5.8040, 6.3172, 4.9795, 5.8890, 5.6460, 4.4639, 7.5212, 4.5436, 6.0694, 4.1583, 5.3722, 5.5638];

#  # A scatter plot of the data.
plot(xdata, ydata, seriestype=:scatter, legend=false)
scatter(xdata, ydata,label="data", xlim=[0,1])

# # Here we compute the best fit line in the least squares sense.
A = hcat(xdata,ones(length(xdata)));
slope, intercept = A \ ydata;

# # Here we plot the least squares line.
p = plot!(x -> slope*x + intercept,0,1,label="least squares line")
display(p)


# Add your code to compute and plot a best fit line in the sense of absolute deviation.

#best fit line
model = Model(GLPK.Optimizer)

@variable(model, a) #recall that a line is just ax + b = y
@variable(model, b)
@variable(model, e[1:length(xdata)])  #this is how to add multiple variables at the same time

@objective(model, Min, sum(e))

#adding constraints
for i in 1:length(xdata)
    @constraint(model, a*xdata[i] + b - ydata[i] <= e[i])
    @constraint(model, -(a*xdata[i] + b - ydata[i]) <= e[i])
end

JuMP.optimize!(model)
println("Solution")
println("Objective: ", value(sum(e)))
println("a : ", value(a))
println("b : ", value(b))
abs = plot!(x -> value(a)*x + value(b),0,1,label="absolute value line")
display(abs)
readline()
