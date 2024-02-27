#Written by Thien K. M. Bui
# Pset7 Computational Mathematics Winter '24
# Optimization code for Nash Equilibrium with mixed
# strategy

# load in packages
using JuMP, GLPK

###  SOLVING THE PRIMAL PROBLEM

# Preparing an optimization model
model = Model(GLPK.Optimizer)


# Declaring variables
# Note here that x0 is unconstrained in the problem.
@variable(model, x0)
@variable(model, y1 >= 0)
@variable(model, y2 >= 0)

# Setting the objective
@objective(model, Min, -y1 + (4/3)*y2)

# Adding constraints M'x - 1x0 >=0 and sum(x) == 1
@constraint(model, constraint1,  y1+y2      == 1)

# Printing the prepared optimization model
print(model)

# Solving the optimization problem
JuMP.optimize!(model)

# Print the information about the optimum.
# We don't print x0 because it's just the value of the objective
println(" \n PRIMAL \n ")
println("Objective value: ", objective_value(model), "\n")
println("Optimal solution:")
println("y1 = ", value(y1))
println("y2 = ", value(y2))
