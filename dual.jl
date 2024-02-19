# MATH271 Computational Mathematics, Rob Thompson PSET4
# Winter 2024
# Written by Thien K. M. Bui 
using JuMP, GLPK

#after adding Slack variables
m = Model(GLPK.Optimizer)

# Declaring variables
@variable(m, x1 >= 0)
@variable(m, x2 >= 0)
@variable(m, x3 >= 0)

# Setting the objective
@objective(m, Min, x1+15*x2+10*x3)

# Adding constraints
@constraint(m, constraint1, -x1 +x2 +4*x3 >= 1)
@constraint(m, constraint2, x1 + 6*x2 - x3 >= 1)


# Printing the prepared optimization model
print(m)

# Solving the optimization problem
JuMP.optimize!(m)

# Print the information about the optimum.
println("Objective value: ", objective_value(m))
println("Optimal solutions:")
println("x1 = ", value(x1))
println("x2 = ", value(x2))
println("x3 = ", value(x3))



