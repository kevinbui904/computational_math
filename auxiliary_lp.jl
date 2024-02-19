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
@variable(m, x4 >= 0)
@variable(m, x5 >= 0)
@variable(m, x6 >= 0)
@variable(m, x7 >= 0)
@variable(m, x8 >= 0)

# Setting the objective
@objective(m, Max, -(x6+x7+x8))

# Adding constraints
@constraint(m, constraint1, x1 + x2 - x3 +x6 == 1)
@constraint(m, constraint2, x2 + x4 +x7 == 2)
@constraint(m, constraint3, x1 - 2*x2 + x5 + x8 == 1)


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
println("x4 = ", value(x4))
println("x5 = ", value(x5))
println("x6 = ", value(x6))
println("x7 = ", value(x7))
println("x8 = ", value(x8))


