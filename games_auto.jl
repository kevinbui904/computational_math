#  In this script we find the (mixed) Nash equilibrium
#  for the monkey vs rabbit rock/paper/scissors game.

# load in packages
using JuMP, GLPK


#####INPUT VARIABLES
M = [
    0 -1;
    1 0;
    -1 1
]#payoff matrix



###  SOLVING THE PRIMAL PROBLEM

# Preparing an optimization model
m = Model(GLPK.Optimizer)


# Declaring variables
# Note here that x0 is unconstrained in the problem.
@variable(m, x0)
@variable(m, x[1:size(M,1)] >= 0)
# @variable(m, x2 >= 0)
# @variable(m, x3 >= 0)

# Setting the objective
@objective(m, Max, x0)

# Adding constraints M'x - 1x0 >=0 and sum(x) == 1
@constraint(m, constraint1, transpose(M)*x[1:size(M, 1)] .- x0 >= 0) #element wise subtraction

@constraint(m, constraint2, sum(x) == 1)
# Printing the prepared optimization model
print(m)

# Solving the optimization problem
JuMP.optimize!(m)

# Print the information about the optimum.
# We don't print x0 because it's just the value of the objective
println(" \n PRIMAL \n ")
println("Objective value: ", objective_value(m), "\n")
println("Optimal solution:")
for i in 1:length(x)
    println("x",i," = ", value(x[i]))
end
###  SOLVING THE DUAL PROBLEM

# Preparing an optimization model
md = Model(GLPK.Optimizer)


# Declaring variables
# Note y0 is unconstrained.

@variable(md, y0)
# x[1:size(M,1)]
@variable(md, y[1:size(M,2)] >= 0)

# Setting the objective
@objective(md, Min, y0)

# Adding constraints My - 1y0 <= 0, sum(y) == 1
@constraint(md, constraint1,  M*y .- y0 <= 0)
@constraint(md, constraint4,  sum(y)     == 1)

# Printing the prepared optimization model
print(md)

# Solving the optimization problem
JuMP.optimize!(md)

# Print the information about the optimum.
println(" \n DUAL \n ")
println("Objective value: ", objective_value(md), "\n")
println("Optimal solution:")
for j in 1:length(y)
    println("y",j," = ", value(y[j]))
end
